output "home_ip" {
  value       = "Home IP to whitelist ${var.rm_home_ip_address}"
  sensitive   = false
  description = "Home IP address allowed through the access rules"
}

output "naughty_list_count" {
  value       = "${length(var.countries_to_challenge)} naughty countries"
  description = "Count of countries on the Naughty Map"
}
