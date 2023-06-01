module "access_rules" {
  source = "./modules/access_rules"

  cloudflare_account_id = var.rm_cloudflare_account_id
}

module "ddos" {
  source = "./modules/ddos"
}
