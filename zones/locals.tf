locals {
  security_headers = jsondecode(file("security_headers.json"))

  # Zone IDs as they are known before apply, so import blocks and for_each keys
  # can both use them. one() fails loudly if a name matches zero or several
  # zones, rather than quietly producing a joined string.
  zone_ids = {
    "rustymagnet.xyz" = var.rustymagnet_zone_id
    "rustymagnet.com" = one(data.cloudflare_zones.all_rm_zones["rustymagnet.com"].result).id
  }
}
