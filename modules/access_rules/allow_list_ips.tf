

resource "cloudflare_list" "foo_list" {
  account_id  = var.cloudflare_account_id
  name        = "foo_list"
  description = "foo IPs for a list"
  kind        = "ip"

  item {
    value {
      ip = "192.0.2.0"
    }
    comment = "one"
  }

  item {
    value {
      ip = "192.0.2.1"
    }
    comment = "two"
  }
}

# resource "cloudflare_firewall_rule" "fw_foo" {
#   zone_id     = var.xyz_zone_id
#   description = "Firewall foo on IP range"
#   filter_id   = cloudflare_filter.filter_foo.id
#   action      = "allow"
# }

# resource "cloudflare_filter" "filter_foo" {
#   zone_id     = var.xyz_zone_id
#   description = "Filter foo on IP range"
#   expression  = "ip.src in $foo_list"  
# }



