resource "cloudflare_zone_setting" "overrides" {
  for_each   = local.zone_settings
  zone_id    = var.rustymagnet_zone_id
  setting_id = each.key
  id         = each.key
  value      = each.value
}
