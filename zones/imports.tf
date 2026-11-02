# Temporary. Two separate jobs are happening here.
#
# 1. The zones themselves. The stored state could not be decoded by provider
#    v5:
#
#      Error: Failed to unmarshal v4 zone state
#      AttributeName("account"): unsupported attribute "account"
#
#    `terraform state rm cloudflare_zone.rusty_magnet_xyz` clears the stale
#    entry without touching Cloudflare; the block below imports it back under
#    the v5 schema. rustymagnet.com has never been in state at all, so its
#    import simply adopts a zone that already exists.
#
#    cloudflare_zone imports on the bare zone ID: no account or zones/ prefix.
#
# 2. Every zone setting. These already exist on both zones -- Cloudflare
#    always has a value for each -- so they are adopted rather than created.
#    cloudflare_zone_setting imports as <zone_id>/<setting_id>.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_zone.rusty_magnet_xyz
  id = local.zone_ids["rustymagnet.xyz"]
}

import {
  to = cloudflare_zone.rustymagnet_com
  id = local.zone_ids["rustymagnet.com"]
}

import {
  for_each = local.zone_settings_pairs
  to       = cloudflare_zone_setting.settings[each.key]
  id       = "${local.zone_ids[each.value.zone]}/${each.value.setting}"
}
