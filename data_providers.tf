data "cloudflare_zone" "website" {
  name = "rustymagnet.xyz"
}


data "cloudflare_list" "ip_list" {
  account_id = var.cloudflare_account_id
  name       = "foo_list"
}

// TODO upgrade to 5+ version and cloudflare_account
data "cloudflare_accounts" "rm_account" {
  name = "rusty_magnets_cloudflare"
}