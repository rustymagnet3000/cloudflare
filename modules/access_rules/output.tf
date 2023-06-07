# child module output: access_rules
output "ar_cf_token" {
  value = var.cloudflare_token
}

output "ar_naughty_list_count" {
  value = "Number of countries to challenge: ${length(var.countries_naughty_list)}"
}

output "ar_cf_account_id" {
  value = var.cloudflare_account_id
}
