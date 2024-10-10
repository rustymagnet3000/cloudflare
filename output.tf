# root


output "account_info" {
  value = "${data.cloudflare_accounts.rm_account.name}:${data.cloudflare_accounts.rm_account.id}"
}

output "zone_info" {
  value = "id:${data.cloudflare_zone.website.id}|status:${data.cloudflare_zone.website.status}|plan:${data.cloudflare_zone.website.plan}"
}


# uses formatlist() to format a list with a specific prefix
# output "north_europe_sites" {
#   value     = [for v in local.north_euro_websites : "${v}"]
#   sensitive = false
# }


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

# output "in_markets" {
#   value = module.firewall_rules.in_markets
# }

# access_rules module

output "home_ip" {
  value     = "Home IP to whitelist ${module.access_rules.ar_home_ip_address_to_whitelist}"
  sensitive = false
}

output "api_tokens_on_cloudflare_account" {
  value = "${length(data.cloudflare_api_token_permission_groups.all.account)} api tokens"
}

output "api_token_id_r2_storage" {
  value = data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"]
}
