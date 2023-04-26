# cloudflare

Cloudflare for personal website.

## Debug Cloudflare API requests from Terraform

```bash
export https_proxy=127.0.0.1:8081 && terraform plan
```

## Gotchas

- Check-in your `terrform.tfstate` in error, you have just compromised the secret `Cloudflare API Token`.

- Set `$CLOUDFLARE_API_TOKEN` it overrides any local var setting.

- If somebody is using the Cloudflare Web UI to add rules, it is easy to get out of sync.  Also, if the machine that runs the `terraform` commands is reset / wipes the local state files, then it will cause things the state to get out of sync,
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

Then just make sure you import it to the correct place.  In my case, it was a Module:

```bash
terraform import module.access_rules.cloudflare_access_rule.foobar account/yy/xxxx
```
