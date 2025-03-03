# root output
output "account_info" {
  value       = "${data.cloudflare_account.rm_account.name}"
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

output "countries" {
  value       = [for i, v in var.countries_naughty_map : "${i} : ${v}"]
  description = "Countries on the Naughty Map"
}

output "naughty_list_count" {
  value       = "${length(var.countries_naughty_map)} naughty countries"
  description = "Count of countries on the Naughty Map"
}

output "find_country_id_of_aussies" {
  value       = var.countries_naughty_map["Kiwis"]
  description = "Lookup a value based on key"
}

output "southern_european_markets" {
  value       = join(" ", local.southern_european_markets)
  description = "Join southern european countries"
}


output "cf_list" {
  value       = "${data.cloudflare_list.ip_list.name} has ${data.cloudflare_list.ip_list.num_items} items"
  description = "List and number of items in a list"

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

