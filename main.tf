# import {
#   id = "${var.cloudflare_account_id}/b3e5edb2c6248b103512217dd6563a72"
#   to = cloudflare_account_member.root_account_member
# }

import {
  for_each = var.countries_to_challenge
  to       = module.access_rules.cloudflare_access_rule.countries_to_challenge[each.key]
  id       = "accounts/${var.cloudflare_account_id}/${each.value.id}"
}

import {
  to = module.access_rules.cloudflare_access_rule.home_whitelist
  id = "accounts/${var.cloudflare_account_id}/eef7806a3eed49e49c8609c8533edb70"
}


# import {
#   to = module.ddos.cloudflare_ruleset.ddos_overrides
#   id = "zones/${var.rustymagnet_zone_id}/4d21379b4f9f4bb088e0729962c8b3cf"
# }

# wants the ruleset not the individual rule
import {
  to = module.redirects.cloudflare_ruleset.redirect_promo_to_post_one
  id = "zones/${var.rustymagnet_zone_id}/809f09290df64762b4bc5248ee3611fc"
}

import {
  to = module.rate_limits.cloudflare_ruleset.zone_rl_custom_response
  id = "zones/${var.rustymagnet_zone_id}/3709fc4f9ecb419e837f057d7b305984"
}

import {
  to = module.transform_rules.cloudflare_ruleset.add_request_headers
  id = "zones/${var.rustymagnet_zone_id}/5cf698bd708a46e8bc079ffad44d398f"
}


import {
  to = module.dns.cloudflare_workers_custom_domain.foo_worker_dns_entry
  id = "${var.cloudflare_account_id}/5a15b3cd3dd5eb6d4ed8528722e21fc3c95d3988"
}

import {
  to = module.zones.cloudflare_zone.rusty_magnet_xyz
  id = var.rustymagnet_zone_id
}


import {
  to = module.firewall_rules.cloudflare_ruleset.my_zone_custom_firewall
  id = "zones/${var.rustymagnet_zone_id}/4263086d67dc4becaf321758f95a9c05"
}



# import {
#   for_each = var.allowed_ips
#   to       = module.firewall_rules.cloudflare_list_item.example_list_item[each.key]
#   id       = "accounts/${var.cloudflare_account_id}/${each.value.id}"
# }



resource "cloudflare_account_member" "root_account_member" {
  account_id = var.cloudflare_account_id
  email      = var.email_of_root_cf_user
  roles = [
    "33666b9c79b9a5273fc7344ff42f953d" # super admin
  ]
}