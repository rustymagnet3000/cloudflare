# root output
output "account_info" {
  value       = data.cloudflare_account.rm_account.name
  description = "Cloudflare Account Info"
}

output "naughty_list_count" {
  value       = "${length(var.countries_to_challenge)} naughty countries"
  description = "Count of countries on the Naughty Map"
}

output "southern_european_markets" {
  value       = join(" ", local.southern_european_markets)
  description = "Join southern european countries"
}



# access_rules module

output "home_ip" {
  value       = "Home IP to whitelist ${module.access_rules.ar_home_ip_address_to_whitelist}"
  sensitive   = false
  description = "Home IP"
}
