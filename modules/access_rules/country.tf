resource "cloudflare_access_rule" "countries_to_challenge" {
  account_id = var.cloudflare_account_id
  for_each   = var.countries_naughty_map
  notes      = "Challenge ${each.key} with country code ${each.value}"
  mode       = "managed_challenge"

  configuration {
    target = "country"
    value  = each.value
  }
}
