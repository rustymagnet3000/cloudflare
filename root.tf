module "access_rules" {
  source = "./modules/access_rules"

  cloudflare_token      = var.rm_cloudflare_token
  cloudflare_account_id = var.rm_cloudflare_account_id
  countries_naughty_map = var.countries_naughty_map
  home_ip_address = var.rm_home_ip_address
  xyz_zone_id = data.cloudflare_zone.website.id
}

module "notifications" {
  source                     = "./modules/notifications"
  cloudflare_account_id      = var.rm_cloudflare_account_id
  su_email_for_notifications = var.rm_email_for_notifications
}
