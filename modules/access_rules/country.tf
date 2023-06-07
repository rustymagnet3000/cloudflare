resource "cloudflare_access_rule" "challenge_anzac" {
  account_id = var.cloudflare_account_id
  notes      = "Challenge ${element(var.countries_naughty_list, count.index)}"
  mode       = "managed_challenge"
  count      = length(var.countries_naughty_list)

  configuration {
    target = "country"
    value  = element(var.countries_naughty_list, count.index)
  }
}


