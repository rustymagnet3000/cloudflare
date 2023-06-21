resource "cloudflare_list" "foo_list" {
  account_id  = var.cloudflare_account_id
  name        = "foo_list"
  description = "foo IPs for a list"
  kind        = "ip"

  item {
    value {
      ip = "192.168.1.128/25"
    }
    comment = "one"
  }

  item {
    value {
      ip = "192.168.0.160/27"
    }
    comment = "two"
  }
}
