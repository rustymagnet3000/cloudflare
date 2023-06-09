# child module output: access_rules
output "ar_cf_token" {
  value = var.cloudflare_token
}

output "ar_home_ip_address_to_whitelist" {
  value = var.home_ip_address
}

output "ar_ip_deny_list" {
  value = length(var.ips_to_deny)
}

