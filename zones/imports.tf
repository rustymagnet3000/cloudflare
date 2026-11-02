# Temporary: re-adopts the zone after its v4-era state entry is removed.
#
# The stored state could not be decoded by provider v5:
#
#   Error: Failed to unmarshal v4 zone state
#   AttributeName("account"): unsupported attribute "account"
#
# `terraform state rm cloudflare_zone.rusty_magnet_xyz` clears the stale entry
# without touching Cloudflare; this block then imports the zone back under the
# v5 schema. cloudflare_zone imports on the bare zone ID, with no account or
# zones/ prefix.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_zone.rusty_magnet_xyz
  id = var.rustymagnet_zone_id
}
