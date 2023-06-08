module "access_rules" {
  source = "./modules/access_rules"

  cloudflare_token      = var.rm_cloudflare_token
  cloudflare_account_id = var.rm_cloudflare_account_id
  countries_naughty_map = var.countries_naughty_map
}

module "notifications" {
  source                     = "./modules/notifications"
  cloudflare_account_id      = var.rm_cloudflare_account_id
  su_email_for_notifications = var.rm_email_for_notifications
}
