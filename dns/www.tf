# added via Pages webUI

# resource "cloudflare_record" "www_cname" {
#   name    = "www.${data.cloudflare_zone.website.name}"
#   type    = "CNAME"
#   ttl     = 1
#   proxied = true
#   value   = "rmhome.pages.dev"
#   zone_id = var.rustymagnet_zone_id
# }
