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

