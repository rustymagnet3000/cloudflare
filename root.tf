module "access_rules" {
  source                 = "./modules/access_rules"
  cloudflare_account_id  = var.cloudflare_account_id
  countries_to_challenge = var.countries_to_challenge
  home_ip_address        = var.rm_home_ip_address
}

module "ddos" {
  source      = "./modules/ddos"
  xyz_zone_id = data.cloudflare_zone.website.id
}

module "dns" {
  source                = "./modules/dns"
  xyz_zone_id           = var.rustymagnet_zone_id
  xyz_zone_name         = data.cloudflare_zone.website.name
  cloudflare_account_id = var.cloudflare_account_id
}

module "firewall_rules" {
  source                = "./modules/firewall_rules"
  cloudflare_account_id = var.cloudflare_account_id
  xyz_zone_id           = var.rustymagnet_zone_id
  challenged_markets    = local.challenged_markets_str
}

module "redirects" {
  source        = "./modules/redirects"
  xyz_zone_name = data.cloudflare_zone.website.name
  xyz_zone_id   = var.rustymagnet_zone_id
}


module "rate_limits" {
  source      = "./modules/rate_limits"
  xyz_zone_id = var.rustymagnet_zone_id
  website     = data.cloudflare_zone.website.name
}

module "tokens" {
  source                = "./modules/tokens"
  cloudflare_account_id = var.cloudflare_account_id
}
module "transform_rules" {
  source      = "./modules/transform_rules"
  xyz_zone_id = var.rustymagnet_zone_id
}
