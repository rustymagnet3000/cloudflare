data "cloudflare_zone" "rustymagnet_zone" {
  zone_id = var.rustymagnet_zone_id
}

# filter only pull Zones for Zones in the Set
data "cloudflare_zones" "all_rm_zones" {
  for_each = var.rustymagnet_zones_set
  account = {
    id = var.cloudflare_account_id
  }
  name = each.value
}