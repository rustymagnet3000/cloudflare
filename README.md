# cloudflare

Cloudflare for personal website.

## Debug Cloudflare API requests from Terraform

```bash
export https_proxy=127.0.0.1:8081 && terraform plan
```

## Gotchas

If you set `$CLOUDFLARE_API_TOKEN` it overrides any local var setting.
