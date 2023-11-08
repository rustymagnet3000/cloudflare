# resource "cloudflare_firewall_rule" "fw_asns_from_list" {
#   count       = length(var.cloudflare_zones_map)
#   zone_id     = var.cloudflare_zones_map[element(keys(var.cloudflare_zones_map), count.index)]
#   description = "Requests coming from lists of ASNs"
#   filter_id   = element(cloudflare_filter.filter_asns_from_list.*.id, count.index)
#   action      = "managed_challenge"
# }



# resource "cloudflare_filter" "filter_asns_from_list" {
#   count       = length(var.cloudflare_zones_map)
#   zone_id     = var.cloudflare_zones_map[element(keys(var.cloudflare_zones_map), count.index)]
#   description = "Requests coming from lists of ASNs"
#   expression  = "(ip.src.asnum in { 50896 200557 })"
# }
