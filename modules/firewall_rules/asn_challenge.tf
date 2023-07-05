resource "cloudflare_firewall_rule" "fw_asns_from_list" {
  zone_id     = var.xyz_zone_id
  description = "Requests coming from lists of ASNs"
  filter_id   = cloudflare_filter.filter_asns_from_list.id
  action      = "managed_challenge"
}


resource "cloudflare_filter" "filter_asns_from_list" {
  zone_id     = var.xyz_zone_id
  description = "Requests coming from lists of ASNs"
  expression  = "(ip.src.asnum in { 50896 200557 })"
}
