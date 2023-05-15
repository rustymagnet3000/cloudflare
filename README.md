# cloudflare

Cloudflare for personal website.

## Authenticate to Cloudflare

Cloudflare advises to use less privileged, short-lived, `API Tokens` instead of the traditional email and long-lived `API Key`. [Reference](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs). This repo now sets two environment variables that are used extensively:

-`CLOUDFLARE_API_TOKEN` ( required for every request sent to Cloudflare )
-`CLOUDFLARE_ACCOUNT_ID` ( required for some API calls to Cloudflare )



## Debug Cloudflare API requests from Terraform

```bash
export https_proxy=127.0.0.1:8081 && terraform plan
```


## Gotchas

### State file is secret

Check-in your `terrform.tfstate` in error, you have just compromised the secret `Cloudflare API Token`.

### Careful about overiding authentication creds

Set `$CLOUDFLARE_API_TOKEN` it overrides any local var setting.

### State mismatch

If somebody is using the Cloudflare Web UI to add rules, it is easy to get out of sync.  Also, if the machine that runs the `terraform` commands is reset / wipes the local state files, then it will cause things the state to get out of sync,
This is how I reproduced the issue and fixed it:

- Create a single Access Rule with Terraform and the CF Provider
- Delete all the state files
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

### Import vs state move
`terraform state mv`


### Import multiple Resources with same name

```terraform
resource "cloudflare_access_rule" "challenge_anzac" {
    ...
    ...
variable "countries_naughty_list" {
  type    = list(string)
  default = ["AU", "NZ"]
}
```

This means any import needs handling with multiple commands:

```bash
terraform import -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[0]" account/<account id>/<rule id>
```

### Test state change

To check the state file was changed as expected, these commands were helpful:

```bash
# remove state
terraform state rm -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[1]"

# import
terraform import -state=terraform.tfstate "module.access_rules.cloudflare_access_rule.my_rule[1]" account/<account id>/<rule id>

# test it worked
▶ terraform plan
No changes. Your infrastructure matches the configuration.
```
