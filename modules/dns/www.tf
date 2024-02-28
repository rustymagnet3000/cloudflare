resource "cloudflare_record" "www_cname" {
  name    = "www.${var.xyz_zone_name}"
  type    = "CNAME"
  ttl     = 1
  proxied = true
  value   = "rustymagnet.xyz"
  zone_id = var.xyz_zone_id
}
