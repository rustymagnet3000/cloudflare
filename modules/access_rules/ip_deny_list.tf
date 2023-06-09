resource "cloudflare_access_rule" "ip_blacklist" {
  account_id = var.cloudflare_account_id
  for_each   = var.ips_to_deny
  notes      = "Block: ${each.key} at ${each.value}"
  mode       = "block"
  configuration {
    target = "ip"
    value  = each.value
  }
}

variable "ips_to_deny" {
  type = map(string)
  default = {
    "kinsta IP to block" = "103.5.140.141"
    "dummy blocked IP"   = "192.168.0.1"
  }
}


resource "cloudflare_firewall_rule" "fw_foo" {
  zone_id     = var.xyz_zone_id
  description = "Firewall foo"
  filter_id   = cloudflare_filter.filter_foo.id
  action      = "block"
}

resource "cloudflare_filter" "filter_foo" {
  zone_id     = var.xyz_zone_id
  description = "Filter foo using the name:ip_deny_list"
  expression  = "ip.src in $ip_deny_list"
}




resource "cloudflare_list" "ip_addresses_to_deny" {
  account_id  = var.cloudflare_account_id
  name        = "ip_deny_list"
  description = "example IPs for a list"
  kind        = "ip"

  item {
    value {
      ip = "103.5.140.141"
    }
    comment = "kinsta IP"
  }
  item {
    value {
      ip = "192.168.0.100"
    }
    comment = "dummy IP"
  }
}
