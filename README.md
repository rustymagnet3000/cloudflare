# cloudflare

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/rustymagnet3000/cloudflare/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/rustymagnet3000/cloudflare/tree/master)

A simple way to manage Cloudflare infrastructure with Terraform.

Every product area is its own Root Module, in its own directory, with its own
state file. There is no root module, no child modules and no wiring between
them. A directory is the unit of everything.

## What a build machine needs

Two credentials. That is the whole story.

| Credential | What it is for | Environment variables |
|---|---|---|
| **R2 API token** | reading and writing state | `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_ENDPOINT_URL_S3` |
| **Cloudflare API token** | changing resources | `CLOUDFLARE_API_TOKEN` |

Plus the identifiers the configuration needs, which are not secrets:

```bash
export TF_VAR_cloudflare_account_id="…"
export TF_VAR_rustymagnet_zone_id="…"
export TF_VAR_rm_emails_for_notifications='["…"]'   # notifications only
```

Any machine holding those can `cd` into any directory and run `terraform init`,
`plan` and `apply`. There is nothing else to bootstrap: no workspace to select,
no module to initialise, no ordering between directories.

## One directory per product

| Directory | State key | Scope | Manages |
|---|---|---|---|
| `access_rules` | `access_rules.tfstate` | account | `cloudflare_access_rule` |
| `bot_management` | `bot_management.tfstate` | zone | `cloudflare_bot_management` |
| `config_rules` | `config_rules.tfstate` | zone | `cloudflare_ruleset` |
| `dns` | `dns.tfstate` | account | `cloudflare_workers_custom_domain` |
| `firewall_rules` | `firewall_rules.tfstate` | zone | `cloudflare_ruleset` |
| `lists` | `lists.tfstate` | account | `cloudflare_list`, `cloudflare_list_item` |
| `notifications` | `notifications.tfstate` | account | `cloudflare_notification_policy` |
| `rate_limits` | `rate_limits.tfstate` | zone | `cloudflare_ruleset` |
| `redirects` | `redirects.tfstate` | zone | `cloudflare_ruleset` |
| `transform_rules` | `transform_rules.tfstate` | zone | `cloudflare_ruleset` |
| `zones` | `zones.tfstate` | zone | `cloudflare_zone`, `cloudflare_zone_setting` |

All eleven share one R2 bucket, `rm-terraform`, and differ only by key.

## Why it is split this way

**Isolated state.** A state file holds one product. Nothing else can be
corrupted by a bad write, and nothing else has to be read to plan a change.

**Quick rollbacks.** Reverting a redirect means reverting one small state file,
not unpicking one change out of a shared one.

**One bad rule does not block a different product.** A broken redirect does not
stop you changing a WAF rule. A `list` that will not apply does not hold up a
notification policy. Each directory fails on its own.

**Scoped tokens are possible.** Because the split follows the API's own
account/zone boundary, a token can be cut to one product. The table above says
which scope each needs.

**Provider versions can differ.** Cloudflare is not shy about breaking changes
— the [v4 to v5 upgrade guide](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/guides/version-5-upgrade)
is a long read. A separate `required_providers` per directory means a new
version can be tried on one product before the rest.

**Plans stay fast.** `plan` reads the state it is given. Eleven small state
files plan quicker than one large one, and only the directory you touched
needs planning at all.

### What it used to be

One root folder, a set of child modules, and every resource in a single state
file. One workflow, one state file, simple — until the resource count grew,
`plan` slowed down, and a provider upgrade meant moving everything at once.

## Checks

Three CircleCI jobs run on every push: `terraform fmt -check -recursive`,
`tflint --recursive`, and `terraform init -backend=false && terraform validate`
in every directory. None of them need a Cloudflare or R2 credential.

## Further reading

- [Free-tier limitations](docs/free-tier.md) — what the free plan will not let you do, by product
- [State management](docs/state.md) — the R2 backend, importing existing resources, import ID formats
- [Troubleshooting](docs/troubleshooting.md) — provider bugs, debugging API calls, running the CI checks locally
