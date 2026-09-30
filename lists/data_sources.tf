data "cloudflare_list" "star_wars_list" {
  account_id = var.cloudflare_account_id
  list_id    = var.list_id
}
