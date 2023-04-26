# cloudflare

Cloudflare for personal website.

## Debug Cloudflare API requests from Terraform

```bash
export https_proxy=127.0.0.1:8081 && terraform plan
```

## Gotchas

- Check-in your `terrform.tfstate` in error, you have just compromised the secret `Cloudflare API Token`.

- Set `$CLOUDFLARE_API_TOKEN` it overrides any local var setting.
