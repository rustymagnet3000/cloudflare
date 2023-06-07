output "rm_cloudflare_account_id" {
  value = var.rm_cloudflare_account_id
}

output "rm_cloudflare_token" {
  value = var.rm_cloudflare_token
}

# access_rules module
output "child_cloudflare_token_access_rules" {
  value = module.access_rules.ar_cf_token
}

output "naughty_list_count" {
  value = module.access_rules.ar_naughty_list_count
}

output "child_cloudflare_account_id_access_rules" {
  value = module.access_rules.ar_cf_account_id
}
