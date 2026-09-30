resource "cloudflare_list" "star_wars_list" {
  account_id  = var.cloudflare_account_id
  name        = "star_wars_list"
  description = "IPs or IP ranges of Star War characters"
  kind        = "ip"
}


resource "cloudflare_list_item" "star_wars_ip_item" {
  for_each   = var.allowed_ips
  account_id = var.cloudflare_account_id
  list_id    = var.list_id
  ip         = each.value.ip_address
  comment    = each.value.comment
}
