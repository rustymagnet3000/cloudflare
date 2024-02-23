module "access_rules" {
  source                = "./modules/access_rules"
  cloudflare_account_id = var.rm_cloudflare_account_id
  countries_naughty_map = var.countries_naughty_map
  home_ip_address       = var.rm_home_ip_address
  xyz_zone_id           = data.cloudflare_zone.website.id
}

module "dns" {
  source                = "./modules/dns"
  xyz_zone_id           = data.cloudflare_zone.website.id
  xyz_zone_name         = data.cloudflare_zone.website.name
  cloudflare_account_id = var.rm_cloudflare_account_id
}

module "redirects" {
  source        = "./modules/redirects"
  xyz_zone_name = data.cloudflare_zone.website.name
  xyz_zone_id   = data.cloudflare_zone.website.id
}

module "transform_rules" {
  source      = "./modules/transform_rules"
  xyz_zone_id = data.cloudflare_zone.website.id
}

module "ddos" {
  source                = "./modules/ddos"
  cloudflare_account_id = var.rm_cloudflare_account_id
  xyz_zone_id           = data.cloudflare_zone.website.id
}
module "zones" {
  source                = "./modules/zones"
  cloudflare_account_id = var.rm_cloudflare_account_id
  xyz_zone_name         = data.cloudflare_zone.website.name
}

module "firewall_rules" {
  source                = "./modules/firewall_rules"
  cloudflare_zones_map  = local.cloudflare_zones_map
  my_markets            = var.my_markets
  cloudflare_account_id = var.rm_cloudflare_account_id
  home_ip_address       = var.rm_home_ip_address
  xyz_zone_id           = data.cloudflare_zone.website.id
  website               = data.cloudflare_zone.website.name
}

module "rate_limits" {
  source                = "./modules/rate_limits"
  cloudflare_account_id = var.rm_cloudflare_account_id
  xyz_zone_id           = data.cloudflare_zone.website.id
  website               = data.cloudflare_zone.website.name
}

module "notifications" {
  source                     = "./modules/notifications"
  cloudflare_account_id      = var.rm_cloudflare_account_id
  su_email_for_notifications = var.rm_email_for_notifications
}
