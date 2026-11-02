# The hostname is built from the zone name, so read it from the API rather
# than hardcoding it.
data "cloudflare_zone" "website" {
  zone_id = var.rustymagnet_zone_id
}
