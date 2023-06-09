# root module
output "website" {
  value = data.cloudflare_zone.website
}


output "rm_cloudflare_account_id" {
  value = var.rm_cloudflare_account_id
}

output "rm_cloudflare_token" {
  value = var.rm_cloudflare_token
}

output "countries" {
  value = [for i, v in var.countries_naughty_map : "${i} is ${v}"]
}

output "naughty_list_count" {
  value = "${length(var.countries_naughty_map)} naughty countries"
}

output "cf_list" {
  value = [for i, v in data.cloudflare_list.ip_list : "${i}:${v}"]
 
}


# access_rules module
output "child_cloudflare_token_access_rules" {
  value = module.access_rules.ar_cf_token
}

output "home_ip" {
  value = "Home IP to whitelist ${module.access_rules.ar_home_ip_address_to_whitelist}"
  sensitive   = false
}

output "ip_deny" {
  value = "deny ${module.access_rules.ar_ip_deny_list} IP addresses"
  sensitive   = false
}
