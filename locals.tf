locals {
  cloudflare_zones_map = {
    for k in var.all_zone_names :
    k => data.cloudflare_zones.all_zone_ids[k].zones[0].id
  }

  southern_european_markets = [
    "\"IT\"",
    "\"FR\"",
    "\"ES\"",
    "\"GR\"",
    "\"PT\"",
  ]

  north_european_websites = [
    ".dk",
    ".no",
    ".se",
    ".nl",
  ]


  north_euro_websites = formatlist("\"rustymagnet%s\"", local.north_european_websites)
}
