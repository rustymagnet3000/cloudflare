# v5 replaced the single cloudflare_zone_settings_override with one
# cloudflare_zone_setting per setting. `value` is a dynamic type, but for_each
# needs one type per map, so the settings are grouped by what the API expects.

locals {
  zone_settings_string = {
    always_use_https    = "on"
    min_tls_version     = "1.2"
    replace_insecure_js = "off"
    security_level      = "medium"
    ssl                 = "strict"
    tls_1_3             = "on"
  }

  zone_settings_number = {
    max_upload = 100
  }

  # One entry per (zone, setting), keyed "<zone>|<setting>". The keys are
  # literals, so for_each and the import blocks can both resolve at plan time.
  zone_settings_string_pairs = {
    for p in setproduct(keys(local.zone_ids), keys(local.zone_settings_string)) :
    "${p[0]}|${p[1]}" => { zone = p[0], setting = p[1] }
  }

  zone_settings_number_pairs = {
    for p in setproduct(keys(local.zone_ids), keys(local.zone_settings_number)) :
    "${p[0]}|${p[1]}" => { zone = p[0], setting = p[1] }
  }
}

resource "cloudflare_zone_setting" "string_settings" {
  for_each   = local.zone_settings_string_pairs
  zone_id    = local.zone_ids[each.value.zone]
  setting_id = each.value.setting
  value      = local.zone_settings_string[each.value.setting]
}

resource "cloudflare_zone_setting" "number_settings" {
  for_each   = local.zone_settings_number_pairs
  zone_id    = local.zone_ids[each.value.zone]
  setting_id = each.value.setting
  value      = local.zone_settings_number[each.value.setting]
}

# security_header takes an object, so it cannot share a for_each with the above.
resource "cloudflare_zone_setting" "security_header" {
  for_each   = local.zone_ids
  zone_id    = each.value
  setting_id = "security_header"
  value      = local.security_headers.value
}
