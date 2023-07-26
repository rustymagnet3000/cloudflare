# resource "cloudflare_firewall_rule" "fw_challenge_ips_from_list" {
#   zone_id     = var.xyz_zone_id
#   description = "Requests coming from lists of bad IPs"
#   filter_id   = cloudflare_filter.filter_challenge_ips_from_list.id
#   action      = "managed_challenge"
# }


# resource "cloudflare_filter" "filter_challenge_ips_from_list" {
#   zone_id     = var.xyz_zone_id
#   description = "Requests coming from lists of bad IPs"
#   expression  = "(ip.src in { 192.168.0.100 192.168.0.101 })"
# }

