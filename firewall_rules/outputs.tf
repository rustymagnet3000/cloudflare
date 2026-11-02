output "challenged_countries_total" {
  value       = length(var.challenged_markets_list)
  description = "Count of country codes challenged by the firewall ruleset"
}

output "challenged_countries" {
  value       = join(" ", formatlist("country:%s", var.challenged_markets_list))
  description = "Challenged country codes, formatted for Cloudflare expressions"
}
