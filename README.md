# cloudflare

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/rustymagnet3000/cloudflare/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/rustymagnet3000/cloudflare/tree/master)

Manage Cloudflare Firewall (WAF), Redirects, Bot Management and more with Terraform.

## Table of contents

- [Free-tier limitations](#free-tier-limitations)
- [Authentication and setup](#authentication-and-setup)
- [State management](#state-management)
- [Debugging](#debugging)
- [Pipeline / CI](#pipeline--ci)

## Free-tier limitations

Many headaches moving Cloudflare infrastructure into Terraform relate to limitations of the `free` zones:

### Limitations of the free Cloudflare tier

| Product | Limitation | Field / expression |
|---|---|---|
| Bot Management | Bot Score not available | `cf.bot_management.score` |
| Bot Management | Verified Bot check not available | `cf.bot_management.verified_bot` |
| Bot Management | Fingerprint hashes not available | `cf.bot_management.ja4` |
| Redirects | Limited number with free tier | x 10 |
| Body Size | Enterprise zone + WAF Advanced required | `http.request.body.size` |
| WAF Score | Enterprise zone + WAF Advanced required | `cf.waf.score` |
| Logs | Only available to Enterprise customers | logpush |
| Lists | Limited number with free tier | x 1 |
| WAF Custom Rules | Limited number with free tier | 5 |
| Rate Limits | Not entitled to exclude cached assets | `requests_to_origin = true` |
| Rate Limits | No custom `counting` without Advanced Rate Limit license | `counting_expression` |
| Rate Limits | No `log` with free zones | `action = "log"` |
| Rate Limits | No custom responses with free zones | `please slow down` |
| DDoS | You can still override DDoS rules with the free tier, but scoped overrides using the `expression` field are not allowed on free zones | — |

### Firewall filters can't include

```text
http.request.method
http.response.code
http.host eq "${var.website}"
```

## Authentication and setup

### Authenticate to Cloudflare

Use a less privileged, short-lived, `API Token` instead of the traditional email and long-lived `API Key`. [Reference](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs).

```bash
# required for every request sent to Cloudflare
# Terraform will pick up the API Token from here
export CLOUDFLARE_API_TOKEN="< token >"

# The Account ID is used in "Account Level" calls to Cloudflare
export CLOUDFLARE_ACCOUNT_ID="abcd"

# to pass the Account ID into variables
export TF_VAR_cloudflare_account_id=$CLOUDFLARE_ACCOUNT_ID
```

### Permissions I used

```text
Account level

- Workers Pipelines
- Notifications
- Transform Rules
- Account WAF
- Workers R2 Storage
- Account Rulesets
- Rule Policies
- Account Filter Lists
- Access: Organizations, Identity Providers, and Groups
- Account Firewall
- Access Rules
- Account Settings
- Logs      # free tier doesn't allow zone level logpush

Zone Level
- Config Rules
- Single Redirect
- Transform Rules
- HTTP DDoS Managed Ruleset
- Bot Management
- Zone Settings
- Zone
- Page Rules
- Firewall Service
- DNS
```

> [!NOTE]
> you have to use the template `Create Additional Tokens` to do anything with `API Tokens`.  These permissions are not viewable if you generate a `custom token`.

```text
All users
- API Tokens
```

## State management

### Cloudflare child modules, size and speed to "plan"

This repo was originally written to have a Root folder and a bunch of Child Modules (firewall rules, redirects, DNS, etc.).  These Child Modules would contain resources.  All resources, from Root of Child Modules would be written into a single State file.  One workflow, one state file. Simple.

What happens if Cloudflare resources managed by your Terraform code grow?  And grow?  The `plan` step will get slower and slower.  Now add in Cloudflare;  CF are infamous for "breaking changes".  See the v4 to v5 Terraform provider upgrade helper [notes](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/guides/version-5-upgrade).  Ouch.  This is where multiple Provider versions and state files are really useful.  You can run different Cloudflare Provider versions.  So you can "test" the latest `Version` in a smaller subset of resources to keep the "breaking changes" to a manageable amount.

In this repo the `notifications` module was re-purposed to have its own State file.

### Backup state file to Cloudflare R2

Almost identical to S3 backups.  When the requests get sent during a `terraform init` it actually sends it to: `https://[bucket_name].[account_id].r2.cloudflarestorage.com`

```text
# environment variables
AWS_ACCESS_KEY_ID     - R2 token
AWS_SECRET_ACCESS_KEY - R2 secret
AWS_ENDPOINT_URL_S3   - R2 location: https://ACCOUNT_ID.r2.cloudflarestorage.com

related info: https://github.com/hashicorp/terraform/issues/33847
```

To test the credentials work, type:

```bash
aws s3api list-buckets --endpoint-url $AWS_ENDPOINT_URL_S3
```

Failed with an error like `Error: failed to get shared config profile`?  You could set `export TF_LOG="DEBUG"` and re-run the `terraform init`.  Better to try and set a local `aws profile`:

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

### State file is secret

If you check-in the state file, which is default named `terraform.tfstate`, you have just compromised your Cloudflare authentication credentials. Time to rotate those creds!

### State mismatch

On day 1 you set up Cloudflare and add a bunch of resources.  On day 2 you set up a repo to manage Cloudflare with Terraform.  What happens?  You need to **import** those rules.  Does that matter?  Example:

- Create a `Cloudflare Access Rule` with Terraform
- Delete the state file
- `terraform init`
- `terraform plan` # all looks good
- `terraform apply`

```text
Error: failed to create access rule: firewallaccessrules.api.duplicate_of_existing (10009)
```

The state is out of sync.  To get it back in sync:

```bash
cf-terraforming import \
  --resource-type "cloudflare_access_rule" \
  --token $CF_TOKEN --account $CF_ACCOUNT_ID
```

Then just make sure you import it to the correct place.  In my case, I needed to `import` the rule into a `module` called `access_rules`:

```bash
terraform import module.access_rules.cloudflare_access_rule.foobar accounts/yy/xxxx
```

### Import multiple resources with the same name

```terraform
resource "cloudflare_access_rule" "challenge_anzac" {
    ...
    ...
variable "countries_naughty_map" {
  type    = list(string)
  default = ["AU", "NZ"]
}
```

This means any import needs handling with multiple commands:

```bash
terraform import -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[0]" accounts/<account id>/<rule id>
```

### Test state change

```bash
# remove state
terraform state rm -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[1]"

# import
terraform import -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[1]" accounts/<account id>/<rule id>

# test it worked
▶ terraform plan
No changes. Your infrastructure matches the configuration.
```

## Debugging

### Debug Cloudflare API requests from Terraform

Almost all issues I experienced related to using the wrong `CLOUDFLARE_API_TOKEN` when making changes via Terraform.  A quick way to see the errors was:

```bash
# Add the certificate to KeyChain "trust"
export https_proxy=127.0.0.1:8081 && terraform plan
```

## Pipeline / CI

### Pipeline checks

```text
# terraform fmt
check terraform formatting

# tflint
Check code for basic mistakes

# terraform init -backend=false
Init the repo without a full state file sync
This flushes out issues with Providers

# terraform validate
Finds issues like " Error: Reference to undeclared resource"
Quicker feedback rather than waiting for `terraform plan` to complete
```
