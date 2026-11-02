# State management

Eleven state files, one per directory, all in the `rm-terraform` R2 bucket and
differing only by key. See the table in the [README](../README.md) for which key
belongs to which directory.

## The R2 backend

Almost identical to an S3 backend. During `terraform init` the request actually
goes to `https://[bucket_name].[account_id].r2.cloudflarestorage.com`.

```text
AWS_ACCESS_KEY_ID     - R2 token
AWS_SECRET_ACCESS_KEY - R2 secret
AWS_ENDPOINT_URL_S3   - R2 location: https://ACCOUNT_ID.r2.cloudflarestorage.com

related info: https://github.com/hashicorp/terraform/issues/33847
```

R2 keys are 32 hex characters and secrets are 64. Both come from the same
screen when the token is created, and the secret is shown once. If a signature
fails, mismatched halves from two different tokens is the usual cause — the
lengths look right either way.

### Testing the credentials

R2 is S3-compatible, so it needs SigV4 signing; a bearer header will not work.
`curl` has a signer built in:

```bash
# lists the bucket, which is the only operation the backend actually performs
curl -s --aws-sigv4 "aws:amz:auto:s3" \
  --user "$AWS_ACCESS_KEY_ID:$AWS_SECRET_ACCESS_KEY" \
  "$AWS_ENDPOINT_URL_S3/rm-terraform" \
  | grep -oE '<Key>[^<]+</Key>'
```

A `403` on the account root (`$AWS_ENDPOINT_URL_S3/`) is normal and means
nothing: `ListBuckets` is an account-level operation that a bucket-scoped token
cannot perform, and Terraform never calls it.

| Response | Meaning |
|---|---|
| `<Key>` lines | working — those are the state files |
| `AccessDenied` | credentials valid, token not scoped to this bucket |
| `InvalidAccessKeyId` | `AWS_ACCESS_KEY_ID` wrong |
| `SignatureDoesNotMatch` | `AWS_SECRET_ACCESS_KEY` wrong, or halves from different tokens |
| `NoSuchBucket` | bucket name or endpoint wrong |

Watch for a trailing slash on `AWS_ENDPOINT_URL_S3`: it turns the path into
`//` and breaks the signature.

### `failed to get shared config profile`

If `terraform init` fails with that rather than a signature error, the backend
is looking for an AWS profile instead of the environment variables. Setting one
locally gets past it:

```bash
brew install awscli

# set KeyID and Secret Key
aws configure --profile cf
AWS Access Key ID [None]: ....xx
AWS Secret Access Key [None]: ...xx
Default region name [None]: WEUR

# check aok
aws configure list --profile cf
```

`export TF_LOG="DEBUG"` before re-running `init` will show which credential
source it is reaching for.

## The state file is secret

If you check in a state file you have just published your Cloudflare
credentials. Rotate them. `.gitignore` covers `*.tfstate*`, but that only helps
if the file keeps its name.

## Importing resources that already exist

On day one you set up Cloudflare by hand. On day two you manage it with
Terraform. Everything already there has to be **imported**, or apply fails:

```text
Error: failed to create access rule: firewallaccessrules.api.duplicate_of_existing (10009)
```

Rulesets are less forgiving in one direction and more in another: a zone allows
only one ruleset per phase, so a missing import fails loudly rather than
creating a duplicate. Access rules and list items have no such constraint and
will happily duplicate.

`cf-terraforming` will find what exists:

```bash
cf-terraforming import \
  --resource-type "cloudflare_access_rule" \
  --token $CF_TOKEN --account $CF_ACCOUNT_ID
```

Prefer an `import` block in an `imports.tf` over `terraform import`. It is
reviewable, it supports `for_each`, and a wrong ID fails the plan rather than
half-writing state.

```hcl
import {
  for_each = var.countries_to_challenge
  to       = cloudflare_access_rule.countries_to_challenge[each.key]
  id       = "accounts/${var.cloudflare_account_id}/${each.value.id}"
}
```

Delete the file once the apply is clean. Do not delete it before: the stack
will then create what it should have adopted.

### Import ID formats

These differ per resource in ways nothing in the schema hints at, and both
halves of an ID are 32 hex characters, so a wrong one looks right.

| Resource | Import ID |
|---|---|
| `cloudflare_zone` | `<zone_id>` |
| `cloudflare_zone_setting` | `<zone_id>/<setting_id>` |
| `cloudflare_ruleset` | `zones/<zone_id>/<ruleset_id>` |
| `cloudflare_access_rule` | `accounts/<account_id>/<rule_id>` |
| `cloudflare_notification_policy` | `<account_id>/<policy_id>` |
| `cloudflare_workers_custom_domain` | `<account_id>/<domain_id>` |
| `cloudflare_list` | `<account_id>/<list_id>` |
| `cloudflare_list_item` | `<account_id>/<list_id>/<item_id>` |

`cloudflare_ruleset` and `cloudflare_access_rule` carry a literal
`zones/` or `accounts/` segment because either can be account- or zone-scoped.
Resources that are only ever account-scoped take no such prefix. Check the
provider docs rather than copying the pattern from a neighbouring resource:

```bash
curl -s "https://raw.githubusercontent.com/cloudflare/terraform-provider-cloudflare/main/docs/resources/<name>.md" \
  | grep -A6 '^## Import'
```

### Finding a ruleset ID

A dashboard URL like `transform-rules/modify-request-header/1d698260…` ends in
the **rule** ID, not the ruleset ID. Importing needs the ruleset:

```bash
curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  "https://api.cloudflare.com/client/v4/zones/$TF_VAR_rustymagnet_zone_id/rulesets" \
  | jq -r '.result[] | select(.kind=="zone") | [.phase, .id, .name] | @tsv'
```

## State written by an older provider

A state file written by provider v4 may not decode under v5, which ships no
upgrader for the old SDK shape:

```text
Error: Failed to unmarshal v4 zone state
AttributeName("account"): unsupported attribute "account"
```

The fix is to drop the entry and re-import it. `state rm` does not touch
Cloudflare, and `prevent_destroy` does not block it — that guard refuses
destroy plans, not state surgery.

```bash
terraform state rm cloudflare_zone.rusty_magnet_xyz
terraform plan      # expect: 1 to import, 0 to add, 0 to change, 0 to destroy
```

Back the state up first. If `terraform state pull` also fails to decode, fetch
the object straight from R2 with the signed `curl` above.

If `state rm` itself fails, edit the state out by hand and push it back:

```bash
jq 'del(.resources[] | select(.type=="cloudflare_zone")) | .serial += 1' \
  zones.tfstate.backup > zones.tfstate.clean
terraform state push zones.tfstate.clean
```

## Renaming or merging resources

Use `moved` blocks, never a bare rename. Terraform reads the old address as an
orphan and plans a destroy, and destroying a `cloudflare_zone_setting` reverts
it to the Cloudflare default.

A destination resource accepts exactly **one** source, so merging several
resources into one needs per-instance moves:

```text
Error: Ambiguous move statements
Each resource can have moved from only one source resource.
```

`moved` blocks take no `for_each`, so every instance is written out. Generate
them rather than typing them, and check the destination keys against what the
new resource declares.

## Checking what is actually in state

```bash
for d in access_rules bot_management config_rules dns firewall_rules lists \
         notifications rate_limits redirects transform_rules zones; do
  echo "== $d"; ( cd "$d" && terraform state list 2>&1 | head )
done
```

Read-only. A directory that errors or comes back empty has never been applied,
and applying it without its import blocks will create duplicates.
