
import {
  for_each = var.countries_to_challenge
  to       = module.access_rules.cloudflare_access_rule.countries_to_challenge[each.key]
  id       = "accounts/${var.cloudflare_account_id}/${each.value.id}"
}

import {
  to = module.access_rules.cloudflare_access_rule.home_whitelist
  id = "accounts/${var.cloudflare_account_id}/eef7806a3eed49e49c8609c8533edb70"
}

# wants the ruleset not the individual rule
# Rate limit
import {
  to = module.rate_limits.cloudflare_ruleset.zone_rl_custom_response
  id = "zones/${var.rustymagnet_zone_id}/3709fc4f9ecb419e837f057d7b305984"
}

import {
  to = module.dns.cloudflare_workers_custom_domain.foo_worker_dns_entry
  id = "${var.cloudflare_account_id}/5a15b3cd3dd5eb6d4ed8528722e21fc3c95d3988"
}

