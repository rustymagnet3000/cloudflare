resource "cloudflare_access_rule" "home_whitelist" {
  account_id = var.cloudflare_account_id
  notes      = "request from home"
  mode       = "whitelist"

  configuration {
    target = "ip"
    value  = var.home_ip_address
  }
}

