# not yet support for import -> cloudflare_list_item
# import {
#   for_each = var.allowed_ips
#   to       = module.firewall_rules.cloudflare_list_item.example_list_item[each.key]
#   id       = "accounts/${var.cloudflare_account_id}/${each.value.id}"
# }

import {
  to = cloudflare_list.star_wars_list
  id = "${var.cloudflare_account_id}/${var.list_id}"
}
