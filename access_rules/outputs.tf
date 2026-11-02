output "naughty_list_count" {
  value       = "${length(var.countries_to_challenge)} naughty countries"
  description = "Count of countries on the Naughty Map"
}
