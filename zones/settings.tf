resource "cloudflare_zone_setting" "overrides" {
  for_each   = local.cloudflare_zid_settings["rustymagnet.xyz"]
  zone_id    = var.rustymagnet_zone_id
  setting_id = each.key
  id         = each.key
  value      = each.value
}