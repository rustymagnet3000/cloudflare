data "cloudflare_rulesets" "rate_limit_info" {
  zone_id = var.xyz_zone_id

  filter {
    kind  = "zone"
    phase = "http_ratelimit"
  }
}
