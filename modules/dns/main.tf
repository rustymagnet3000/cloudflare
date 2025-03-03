resource "cloudflare_workers_custom_domain" "foo_worker_dns_entry" {
  account_id  = var.cloudflare_account_id
  hostname    = "foobar.${var.xyz_zone_name}"
  service     = "foo"
  environment = "production"
  zone_id     = var.xyz_zone_id
}
