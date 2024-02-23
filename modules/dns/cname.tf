resource "cloudflare_record" "example" {
  zone_id = var.xyz_zone_id
  name    = "www"
  value   = "foo.rustymagnet3000.workers.dev"
  type    = "CNAME"
  ttl     = 3600
  proxied = true
}
