# cloudflare

Manage Cloudflare's Web App Firewall ( WAF ) with Terraform.

#### Authenticate to Cloudflare

Use a less privileged, short-lived, `API Token` instead of the traditional email and long-lived `API Key`. [Reference](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs).


```shell

# required for every request sent to Cloudflare
# Terraform will pick up the API Token from here 
export CLOUDFLARE_API_TOKEN="< token >"

# The Account ID is used in "Account Level" calls to Cloudflare
export CLOUDFLARE_ACCOUNT_ID="abcd"

# to pass the Account ID into variables
export TF_VAR_cloudflare_account_id=$CLOUDFLARE_ACCOUNT_ID
```

#### Permissions I used

```shell
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

```shell
All users 
- API Tokens
```

#### Debug Cloudflare API requests from Terraform

Almost all issues I experienced related to using the wrong `CLOUDFLARE_API_TOKEN` when making change via Terraform.  A quick way to see the errors was:

```shell
# Add the certificate to KeyChain "trust"
export https_proxy=127.0.0.1:8081 && terraform plan
```


#### Limitations of free Cloudflare tier

```shell
# No bot management values
cf.bot_management.score eq 1
not cf.bot_management.verified_bot

# LogPush not available on anything apart from Enterprise Plan
https://developers.cloudflare.com/logs/about/

# Advanced Rate Limits
no counting expression allowed
action = "log" not allowed with free zones
"log" with a an Action Response block not allowed ( as "log" overrides the response block )

# Firewall Filters can't include
http.request.method
http.response.code
http.host eq "${var.website}"

# ddos overrides
You can still override DDOS rules with the free tier
```



#### State file is secret

If you check-in the state file, which is default named `terrform.tfstate`, you have just compromised your Cloudflare authentication credentials. Time to rotate those creds !

### State mismatch

On day 1 you set up Cloudflare and add a bunch of resources.  On day 2 you set up a repo to manage Cloudflare with Terraform.  What happens ?  You need to **import** those rules.  Does that matter ?  Example:

- Create a `Cloudflare Access Rule` with Terraform
- Delete the state file
- `terraform init`
- `terraform plan` # all looks good
- `terraform apply`

> Error: failed to create access rule: firewallaccessrules.api.duplicate_of_existing (10009)

The state is out of sync.  To get it back in sync:

```bash
cf-terraforming import \
  --resource-type "cloudflare_access_rule" \
  --token $CF_TOKEN --account $CF_ACCOUNT_ID
```

Then just make sure you import it to the correct place.  In my case, I needed to `import` the rule into a `module` called `access_rules`:

```bash
terraform import module.access_rules.cloudflare_access_rule.foobar account/yy/xxxx
```

#### Import multiple Resources with same name

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
terraform import -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[0]" account/<account id>/<rule id>
```

#### Test state change

```bash
# remove state
terraform state rm -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[1]"

# import
terraform import -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[1]" account/<account id>/<rule id>

# test it worked
▶ terraform plan
No changes. Your infrastructure matches the configuration.
```
