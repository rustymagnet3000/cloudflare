# root module
output "website" {
  value = data.cloudflare_zone.website
}


output "rm_cloudflare_account_id" {
  value = var.rm_cloudflare_account_id
}


output "countries" {
  value = [for i, v in var.countries_naughty_map : "${i} is ${v}"]
}

output "naughty_list_count" {
  value = "${length(var.countries_naughty_map)} naughty countries"
}

output "cf_list" {
  value = "${data.cloudflare_list.ip_list.name} has ${data.cloudflare_list.ip_list.numitems} items"
 
}


# access_rules module

output "home_ip" {
  value = "Home IP to whitelist ${module.access_rules.ar_home_ip_address_to_whitelist}"
  sensitive   = false
}

# output "ip_deny" {
#   value = "deny ${module.access_rules.ar_ip_deny_list} IP addresses"
#   sensitive   = false
# }
