# root module
output "Status" {
  value = data.cloudflare_zone.website.status
}

output "Plan" {
  value = data.cloudflare_zone.website.plan
}

# useful to see how to get the account ID from a specific Zone Name
output "account_id" {
  value = data.cloudflare_zones.all_zone_ids["rustymagnet.xyz"].id
}

output "all_zones" {
  value = [for k, v in local.cloudflare_zones_map : "${k} -> ${v}"]
}

output "zone_id_lookup" {
  value = local.cloudflare_zones_map["rustymagnet.xyz"]
}
output "countries" {
  value = [for i, v in var.countries_naughty_map : "${i} : ${v}"]
}

output "naughty_list_count" {
  value = "${length(var.countries_naughty_map)} naughty countries"
}

output "find_country_id_of_aussies" {
  value = var.countries_naughty_map["Aussies"]
}

output "southern_european_markets" {
  value = join(" ", local.southern_european_markets)
}


output "cf_list" {
  value = "${data.cloudflare_list.ip_list.name} has ${data.cloudflare_list.ip_list.numitems} items"

}

# firewall_rules module

output "in_markets" {
  value = module.firewall_rules.in_markets
}

# access_rules module

output "home_ip" {
  value     = "Home IP to whitelist ${module.access_rules.ar_home_ip_address_to_whitelist}"
  sensitive = false
}

# rate limit
output "rl" {
  value     = module.rate_limits.zone_rate_limit
  sensitive = false
}

# output "ip_deny" {
#   value = "deny ${module.access_rules.ar_ip_deny_list} IP addresses"
#   sensitive   = false
# }
