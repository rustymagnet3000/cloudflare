module "access_rules" {
  source = "./modules/access_rules"

  cloudflare_token      = var.rm_cloudflare_token
  cloudflare_account_id = var.rm_cloudflare_account_id
}
