# v5 replaced the single cloudflare_zone_settings_override with one
# cloudflare_zone_setting per setting.
#
# The map holds mixed types on purpose: for_each over an object keeps each
# attribute's own type, and cloudflare_zone_setting.value is a dynamic type, so
# max_upload stays a number and security_header stays an object.

locals {
  zone_settings = {
    security_level      = "medium",
    always_use_https    = "on",
    min_tls_version     = "1.2",
    tls_1_3             = "on",
    ssl                 = "strict",
    max_upload          = 100
    replace_insecure_js = "off"
    security_header     = local.security_headers.value
    # true_client_ip_header is not editable on free zones
  }

  # One entry per (zone, setting), keyed "<zone>|<setting>", so a single
  # resource covers both zones. The keys are literals, so for_each resolves at
  # plan time.
  zone_settings_pairs = {
    for p in setproduct(keys(local.zone_ids), keys(local.zone_settings)) :
    "${p[0]}|${p[1]}" => { zone = p[0], setting = p[1] }
  }
}

resource "cloudflare_zone_setting" "settings" {
  for_each   = local.zone_settings_pairs
  zone_id    = local.zone_ids[each.value.zone]
  setting_id = each.value.setting
  value      = local.zone_settings[each.value.setting]
}
