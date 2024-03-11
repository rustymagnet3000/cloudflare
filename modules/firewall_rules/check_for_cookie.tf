resource "cloudflare_ruleset" "my_zone_custom_firewall" {
  zone_id     = var.xyz_zone_id
  name        = "my_firewall_rules_inside_ruleset"
  description = "Zone firewall rules"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "managed_challenge"
    expression  = <<EOF
                (
                    http.request.uri.path contains "/"
                    and not any(lower(http.request.headers.names[*])[*]
                    contains "authorization")
                    and ip.geoip.country in { ${join(" ", var.my_markets)} }
                )
    EOF
    description = "Log requests that don't send auth credentials"
    enabled     = true
  }
}
