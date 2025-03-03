data "cloudflare_zone" "website" {
  zone_id = var.rustymagnet_zone_id
}

data "cloudflare_list" "ip_list" {
  account_id = var.cloudflare_account_id
  list_id    = "c6bba31b2035423f9a65f2e9ff5dec46"
}

data "cloudflare_account" "rm_account" {
  account_id = var.cloudflare_account_id
}