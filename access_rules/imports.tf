# Temporary: adopts the access rules that already exist in Cloudflare into
# this stack's fresh state file, instead of creating duplicates.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  for_each = var.countries_to_challenge
  to       = cloudflare_access_rule.countries_to_challenge[each.key]
  id       = "${var.cloudflare_account_id}/${each.value.id}"
}
