resource "cloudflare_access_rule" "countries_to_challenge" {
  account_id = var.cloudflare_account_id
  for_each   = var.countries_to_challenge
  notes      = "Challenge ${each.key} with country code ${each.value.country_code}"
  mode       = "managed_challenge"
  configuration = {
    target = "country"
    value  = each.value.country_code
  }
}


resource "cloudflare_access_rule" "home_whitelist" {
  account_id = var.cloudflare_account_id
  notes      = "request from home"
  mode       = "whitelist"

  configuration = {
    target = "ip"
    value  = var.home_ip_address
  }
}
