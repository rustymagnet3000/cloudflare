# The zone name is interpolated into ruleset names and descriptions, so read it
# from the API rather than hardcoding it.
data "cloudflare_zone" "website" {
  zone_id = var.rustymagnet_zone_id
}

data "cloudflare_rulesets" "rate_limit_info" {
  zone_id = var.rustymagnet_zone_id
}
