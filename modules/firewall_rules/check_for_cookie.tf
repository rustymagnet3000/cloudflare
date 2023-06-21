resource "cloudflare_firewall_rule" "fw_cookie_presence" {
  zone_id     = var.xyz_zone_id
  description = "Log if request is missing the foo-cookie"
  filter_id   = cloudflare_filter.filter_cookie_presence.id
  # action = "log" not allowed with free account https://developers.cloudflare.com/firewall/
  action      = "managed_challenge"
}

resource "cloudflare_filter" "filter_cookie_presence" {
  zone_id     = var.xyz_zone_id
  description = "Fire if request is missing the foo-cookie"
  expression  = <<EOF
                    not any(lower(http.request.headers.names[*])[*] contains "foo-cookie") 
                    and http.host eq "${var.website}"
                EOF
}
