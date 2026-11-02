resource "cloudflare_workers_custom_domain" "foo_worker_dns_entry" {
  account_id  = var.cloudflare_account_id
  hostname    = "foobar.${data.cloudflare_zone.website.name}"
  service     = "foo"
  environment = "production"
  zone_id     = var.rustymagnet_zone_id
}
