# root output
output "account_info" {
  value       = data.cloudflare_account.rm_account.name
  description = "Cloudflare Account Info"
}

# output "zone_info" {
#   value       = "id:${data.cloudflare_zone.website.id}|status:${data.cloudflare_zone.website.status}"
#   description = "Zone Info"
# }

output "total_challenged_markets" {
  value = length(var.challenged_markets_list)
}

output "challenged_markets_as_str" {
  value = local.challenged_markets_str
}

output "naughty_list_count" {
  value       = "${length(var.countries_to_challenge)} naughty countries"
  description = "Count of countries on the Naughty Map"
}

output "southern_european_markets" {
  value       = join(" ", local.southern_european_markets)
  description = "Join southern european countries"
}



# firewall_rules module

# output "in_markets" {
#   value = module.firewall_rules.in_markets
# }

# access_rules module

output "home_ip" {
  value       = "Home IP to whitelist ${module.access_rules.ar_home_ip_address_to_whitelist}"
  sensitive   = false
  description = "Home IP"
}

