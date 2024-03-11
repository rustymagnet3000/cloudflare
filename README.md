# cloudflare

Managing Cloudflare's Web App Firewall ( WAF ) via Terraform.

## Learnings

#### Limitations of free Cloudflare tier

```shell
# No bot management values
cf.bot_management.score eq 1
not cf.bot_management.verified_bot

# Advanced Rate Limits
  # no counting expression allowed
  #  action = "log" not allowed with free zones
    
# Firewall Filters can't include
http.request.method
http.response.code
http.host eq "${var.website}"

# ddos overrides
You can still override DDOS rules with the free tier
```

#### Authenticate to Cloudflare

Use less privileged, short-lived, `API Tokens` instead of the traditional email and long-lived `API Key`. [Reference](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs).

#### Environment variables

To avoid reading in TF_VARs and the spaghetti complexity of sharing thoses with Modules, set:

-`CLOUDFLARE_API_TOKEN` ( required for every request sent to Cloudflare )
-`CLOUDFLARE_ACCOUNT_ID` ( required for some API calls to Cloudflare )

#### Debug Cloudflare API requests from Terraform

```bash
export https_proxy=127.0.0.1:8081 && terraform plan
```

#### State file is secret

If you check-in the state file, which is default named `terrform.tfstate`, you have just compromised your Cloudflare authentication credentials. Time to rotate those creds !

#### Careful about overiding authentication creds

Set `$CLOUDFLARE_API_TOKEN` it overrides any local var setting.

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
cf-terraforming import --resource-type "cloudflare_access_rule" --token $CF_TOKEN --account $CF_ACCOUNT_ID
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
