resource "cloudflare_account_member" "foo_email" {
  account_id    = var.cloudflare_account_id
  email_address = "samples-coyest0f@icloud.com"
  role_ids      = ["f2b20eaa1a5d4af42b53ac16238c99c7"]
  status        = "accepted"
}
