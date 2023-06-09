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
    "dummy blocked IP" = "192.168.0.1"
  }
}