
variable "allowed_ips" {
  type = map(string)
  default = {
    "luke" = "192.168.1.128/25"
    "han"  = "192.168.0.160/27"
    yoda   = "192.168.0.1"
    darth  = "192.168.0.2"
  }
}

resource "cloudflare_list" "foo_list" {
  account_id  = var.cloudflare_account_id
  name        = "foo_list"
  description = "foo IPs for a list"
  kind        = "ip"
}


resource "cloudflare_list_item" "example_list_item" {
  for_each   = var.allowed_ips
  account_id = var.cloudflare_account_id
  list_id    = var.allow_list_id
  ip         = each.value
  comment    = each.key
}