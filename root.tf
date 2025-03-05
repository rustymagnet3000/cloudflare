module "access_rules" {
  source                 = "./modules/access_rules"
  cloudflare_account_id  = var.cloudflare_account_id
  countries_to_challenge = var.countries_to_challenge
  home_ip_address        = var.rm_home_ip_address
}

module "dns" {
  source                = "./modules/dns"
  xyz_zone_id           = var.rustymagnet_zone_id
  xyz_zone_name         = data.cloudflare_zone.website.name
  cloudflare_account_id = var.cloudflare_account_id
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
  source      = "./modules/ddos"
  xyz_zone_id = data.cloudflare_zone.website.id
}
module "zones" {
  source                = "./modules/zones"
  cloudflare_account_id = var.cloudflare_account_id
  xyz_zone_name         = data.cloudflare_zone.website.name
}

module "firewall_rules" {
  source                = "./modules/firewall_rules"
  cloudflare_account_id = var.cloudflare_account_id
  xyz_zone_id           = data.cloudflare_zone.website.id
  challenged_markets    = local.challenged_markets_str
  allowed_ips = var.allowed_ips
}

module "rate_limits" {
  source      = "./modules/rate_limits"
  xyz_zone_id = var.rustymagnet_zone_id
  website     = data.cloudflare_zone.website.name
}

# removed so different CF Provider versions could be used to test "breaking changes" of v4->v5 upgrade
# module "notifications" {
#   source                   = "./modules/notifications"
#   cloudflare_account_id    = var.cloudflare_account_id
#   emails_for_notifications = var.rm_emails_for_notifications
# }

module "tokens" {
  source                = "./modules/tokens"
  cloudflare_account_id = var.cloudflare_account_id
}
