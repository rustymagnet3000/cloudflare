# Temporary: adopts the ruleset that already exists in Cloudflare into this
# stack's fresh state file, instead of creating a second one.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_ruleset.my_zone_custom_firewall
  id = "zones/${var.rustymagnet_zone_id}/4cc43003171a4515bca43725091c6294"
}
