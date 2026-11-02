# Temporary: adopts the ruleset that already exists in Cloudflare into this
# stack's fresh state file, instead of creating a second one.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_ruleset.add_request_headers
  id = "zones/${var.rustymagnet_zone_id}/a031da46449048108babde71c1545f52"
}
