# Temporary: adopts the ruleset that already exists in Cloudflare into this
# stack's fresh state file, instead of creating a second one.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_ruleset.add_request_headers
  id = "${var.rustymagnet_zone_id}/1d69826067ea4cf2b660c6429a6e7eeb"
}
