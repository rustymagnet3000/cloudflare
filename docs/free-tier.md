# Free-tier limitations

Many headaches moving Cloudflare infrastructure into Terraform relate to
limitations of the `free` zones. The configuration in this repo is shaped by
them: where a rule looks oddly basic, this table is usually why.

| Product | Limitation | Field / expression |
|---|---|---|
| Bot Management | Bot Score not available | `cf.bot_management.score` |
| Bot Management | Verified Bot check not available | `cf.bot_management.verified_bot` |
| Bot Management | Fingerprint hashes not available | `cf.bot_management.ja4` |
| Bot Management | Super Bot Fight Mode is Pro and above | `sbfm_*` |
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
| Rate Limits | Mitigation timeout fixed at 10s | `mitigation_timeout` |
| Zone settings | `true_client_ip_header` not editable | — |
| DDoS | You can still override DDoS rules with the free tier, but scoped overrides using the `expression` field are not allowed on free zones | — |
| Snippets | Not available on free zones at all; paid plans only since GA (July 2026). Free zones had 5 per zone during the beta | — |

## How these show up

Not entitled is not the same as not supported. The provider will accept the
configuration and Cloudflare will reject it at apply time, usually with a clear
message:

```text
Error: error creating ruleset Account level rate limits
not entitled to create custom rulesets
```

```text
there are 2 errors: the use of field http.host is not allowed, the use of
field http.request.method is not allowed, an higher Advanced Rate Limiting
plan is required
```

That makes trying something the cheapest way to find out whether a free zone
allows it — a rejected apply changes nothing.
