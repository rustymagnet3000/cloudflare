# resource "cloudflare_firewall_rule" "fw_foo" {
#   zone_id     = var.xyz_zone_id
#   description = "Firewall foo on IP range"
#   filter_id   = cloudflare_filter.filter_foo.id
#   action      = "bypass"
#   products    = ["waf", "securityLevel", "rateLimit"]
# }

# resource "cloudflare_filter" "filter_foo" {
#   zone_id     = var.xyz_zone_id
#   description = "Filter foo on IP range"
#   expression  = "ip.src in $foo_list"
# }

