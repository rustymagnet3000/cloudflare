locals {
  cloudflare_zones_map = {
    for k in lo :
    k => data.cloudflare_zones.all_zone_ids[k].zones[0].id
  }


  challenged_markets_str = join(" ", formatlist("\"country-code:%s\"", var.challenged_markets_list))

  southern_european_markets = [
    "\"IT\"",
    "\"FR\"",
    "\"ES\"",
    "\"GR\"",
    "\"PT\"",
  ]
  zone_settings = {
    "security_level" = "medium",
    "ssl"            = "full",
  }
}

