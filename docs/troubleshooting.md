# Troubleshooting

## Running the CI checks locally

The three CircleCI jobs, in the order they are cheapest to run. None need a
Cloudflare or R2 credential.

```bash
# formatting
terraform fmt -check -recursive

# basic mistakes
TFLINT_CONFIG_FILE="$PWD/.tflint.hcl" tflint --recursive

# providers resolve, and the configuration makes sense
for d in */; do
  ls -1 "$d"*.tf >/dev/null 2>&1 || continue
  ( cd "$d" && terraform init -backend=false -upgrade && terraform validate )
done
```

`terraform validate` catches things like `Error: Reference to undeclared
resource` without waiting for a `plan` to reach the API.

`TFLINT_CONFIG_FILE` must be set, and must be absolute. With `--recursive`,
tflint looks for a config in each directory it visits, so the root
`.tflint.hcl` is otherwise ignored and the run reports far less than CI does.

`terraform_standard_module_structure` is disabled in `.tflint.hcl`. It expects
`main.tf` and `outputs.tf` in a reusable child module, and there are no child
modules here — it was 14 of 22 findings.

## The provider is sometimes the problem

`cloudflare_bot_management` does not round-trip several fields. The provider
writes them, reads back something else, and Terraform rejects its own
successful write:

```text
Error: Provider produced inconsistent result after apply
.bot_preference_sync_enabled: was cty.True, but now null
.ai_bots_protection: was cty.StringVal("block"), but now cty.StringVal("disabled")
```

Both are open upstream and unfixed:

- [#7385](https://github.com/cloudflare/terraform-provider-cloudflare/issues/7385) — `bot_preference_sync_enabled` is never sent or read
- [#7411](https://github.com/cloudflare/terraform-provider-cloudflare/issues/7411) — `ai_bots_protection = "block"` comes back `"disabled"`
- [#6727](https://github.com/cloudflare/terraform-provider-cloudflare/issues/6727) — the general case on this resource

Before assuming a misconfiguration, search the tracker:

```bash
gh api -X GET search/issues \
  --raw-field q='repo:cloudflare/terraform-provider-cloudflare <attribute name>' \
  --jq '.items[] | "#\(.number) [\(.state)] \(.title)"'
```

### `optional` and `optional, computed` do not protect you

A `computed` attribute may be filled in by the provider **when config is null**.
Once a value is set, the provider must return exactly that value either way, so
`optional, computed` is no defence against the error above.

## Provider versions move on their own

Every directory pins `~> 5.28`, which means `>= 5.28, < 6.0`. The pin is a
floor, not a ceiling: new minor releases arrive without a change here, and
`.terraform.lock.hcl` is gitignored, so there is no diff to review when they
do. Both bot management bugs above landed between 5.27 and 5.28 invisibly.

Narrowing a pin to `~> 5.28.1` stops that for one directory, at the cost of a
deliberate bump per release.

```bash
# what each directory pins, against what it has actually locked
for d in */; do
  d=${d%/}; [ -f "$d/versions.tf" ] || continue
  printf '%-18s pin:%-12s locked:%s\n' "$d" \
    "$(grep -oE 'version = "[^"]+"' "$d/versions.tf" | head -1 | sed 's/version = //')" \
    "$(grep -A1 'cloudflare/cloudflare' "$d/.terraform.lock.hcl" 2>/dev/null | grep -oE 'version *= *"[^"]+"' | sed 's/.*"\(.*\)"/\1/')"
done
```

## Debugging Cloudflare API requests

Almost all issues come down to the wrong `CLOUDFLARE_API_TOKEN`. The quickest
way to see what is actually being sent:

```bash
# add the proxy certificate to KeyChain "trust" first
export https_proxy=127.0.0.1:8081 && terraform plan
```

`export TF_LOG="DEBUG"` is the lighter option, and enough for backend problems.

## Zone settings that will not stick

Check what the zone actually reports before assuming Terraform is wrong:

```bash
curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  "https://api.cloudflare.com/client/v4/zones/$TF_VAR_rustymagnet_zone_id/settings" \
  | jq -r '.result[] | [.id, (.value|tostring), (.editable|tostring)] | @tsv'
```

The `editable` column is the useful one — a setting the plan will not hold is
often one the plan was never allowed to change. See
[free-tier limitations](free-tier.md).
