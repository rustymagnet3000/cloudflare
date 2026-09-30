# filter only pull Zones for Zones in the Set
# Pull this type of Map data.cloudflare_zones.all_rm_zones["rustymagnet.com"] into state file
data "cloudflare_zones" "all_rm_zones" {
  for_each = toset(var.rustymagnet_zones_set)
  account = {
    id = var.cloudflare_account_id
  }
  name = each.value
}
