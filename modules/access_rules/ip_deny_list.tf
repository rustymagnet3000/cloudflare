
resource "cloudflare_list" "ip_deny_list" {
  account_id  = var.cloudflare_account_id
  for_each    = var.ips_to_deny
  name        = "ip_deny_list"
  description = "example IPs for a list"
  kind        = "ip"

  item {
    value {
      ip = each.value
    }
    comment = each.key
  }
}


variable "ips_to_deny" {
  type = map(string)
  default = {
    "dummy ip to deny" = "192.0.2.1"
  }
}