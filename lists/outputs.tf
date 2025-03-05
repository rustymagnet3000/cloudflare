output "stars_wars_list" {
  value       = "${data.cloudflare_list.star_wars_list.name} has ${data.cloudflare_list.star_wars_list.num_items} items"
  description = "List and number of items in a list"
}
