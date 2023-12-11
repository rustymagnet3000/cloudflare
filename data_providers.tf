data "cloudflare_zones" "all_zone_ids" {
  for_each = toset(var.all_zone_names)
  filter {
    name = each.key
  }
}

data "cloudflare_zone" "website" {
  name = "rustymagnet.xyz"
}


data "cloudflare_list" "ip_list" {
  account_id = var.rm_cloudflare_account_id
  name       = "foo_list"
}

