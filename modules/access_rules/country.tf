resource "cloudflare_access_rule" "challenge_anzac" {
  account_id = var.cloudflare_account_id
  notes      = "Challenge Australians and New Zealanders who like cricket :)"
  mode       = "managed_challenge"
  count      = length(var.countries_naughty_list)

  configuration {
    target = "country"
    value  = element(var.countries_naughty_list, count.index)
  }
}

variable "countries_naughty_list" {
  type    = list(string)
  default = ["AU", "NZ"]
}
