# Temporary: adopts the ruleset that already exists in Cloudflare into this
# stack's fresh state file, instead of creating a second one.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_ruleset.redirect_promo_to_post_one
  id = "zones/${var.rustymagnet_zone_id}/1c71afd3a6ed434f9a58bc70bffdee68"
}
