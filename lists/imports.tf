# Temporary: adopts the list and its items that already exist in Cloudflare
# into this stack's fresh state file, instead of creating a second list.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_list.star_wars_list
  id = "${var.cloudflare_account_id}/${var.list_id}"
}

import {
  for_each = var.allowed_ips
  to       = cloudflare_list_item.star_wars_ip_item[each.key]
  id       = "${var.cloudflare_account_id}/${var.list_id}/${each.value.id}"
}
