removed {
  from = cloudflare_zone_setting.overrides

  lifecycle {
    destroy = false
  }
}

# TODO: handle the same style, with a map that looks up the Zone ID like below but pulls the settings
# resource "cloudflare_zone_setting" "overrides" {
#   for_each   = local.zones_and_settings_map
#   zone_id    = local.cloudflare_domains_map[each.key]
#   setting_id = each.key
#   id         = each.value.value
#   value      = each.value.value.always_use_https
# }
