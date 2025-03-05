import {
  to = cloudflare_zone.rusty_magnet_xyz
  id = var.rustymagnet_zone_id
}

import {
  for_each = local.zone_settings
  to = cloudflare_zone_setting.overrides[each.key]
  id = "${var.rustymagnet_zone_id}/${each.key}"
}

