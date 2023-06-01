resource "cloudflare_firewall_rule" "fw_rule_for_bad_asns" {
  count       = length(var.my_zones)
  zone_id     = data.cloudflare_zone.xyz.id
  description = "Track some ASNs"
  filter_id   = element(cloudflare_filter.filter_for_bad_asns.*.id, count.index)
  action      = "log"
  priority    = 32
}

resource "cloudflare_filter" "filter_for_bad_asns" {
  count       = length(var.my_zones)
  zone_id     = data.cloudflare_zone.xyz.id
  paused      = false
  description = "Track some ASNs"
  expression  = "http.request.uri.path eq \"/\" and (ip.geoip.asnum eq 24940 or ip.geoip.asnum eq 36352 or ip.geoip.asnum eq 397630)"
}
# http.host eq \"${var.my_zones[count.index]}\" and
