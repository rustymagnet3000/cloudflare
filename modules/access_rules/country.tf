resource "cloudflare_access_rule" "challenge_australians" {
  account_id = var.cloudflare_account_id
  notes      = "Challenge Australians who like cricket :)"
  mode       = "managed_challenge"
  configuration {
    target = "country"
    value  = "AU"
  }
}
