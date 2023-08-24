resource "cloudflare_ruleset" "my_zone_custom_firewall" {
  zone_id     = var.xyz_zone_id
  name        = "my_firewall_rules_inside_ruleset"
  description = "Zone firewall rules"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    # action = "log" not allowed with free account https://developers.cloudflare.com/firewall/
    action      = "managed_challenge"
    expression  = <<EOF
                (
                    http.host eq "${var.website}"
                    and (http.request.uri.path contains "/foo/")
                    and not any(lower(http.request.headers.names[*])[*]
                    contains "authorization")
                    and not ip.geoip.country in { ${join(" ", var.my_markets)} }
                )
    EOF
    description = "Log requests that don't send auth credentials"
    enabled     = true
  }
}