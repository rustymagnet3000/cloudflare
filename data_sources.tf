data "cloudflare_zone" "website" {
  zone_id = var.rustymagnet_zone_id
}

data "cloudflare_account" "rm_account" {
  account_id = var.cloudflare_account_id
}

# data "cloudflare_access_rule" "naughty" {
#   account_id = var.cloudflare_account_id
#   filter    = {
#     configuration = {
#     target = "country"
#     }
#     mode = "managed_challenge"
#   }
# }
