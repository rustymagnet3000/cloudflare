# Temporary: adopts the ruleset that already exists in Cloudflare into this
# stack's fresh state file, instead of creating a second one.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_ruleset.zone_rl_custom_response
  id = "zones/${var.rustymagnet_zone_id}/3709fc4f9ecb419e837f057d7b305984"
}
