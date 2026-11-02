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

module "tokens" {
  source                = "./modules/tokens"
  cloudflare_account_id = var.cloudflare_account_id
}
