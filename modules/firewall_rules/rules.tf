resource "cloudflare_ruleset" "my_zone_custom_firewall" {
  zone_id     = var.xyz_zone_id
  name        = "my_firewall_rules_inside_ruleset"
  description = "Zone firewall rules"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression = <<EOF
    (
      http.request.uri.path.extension in { "php" "jsp" "cgi" }
    )
    EOF

     description = "Block any requests with file extensions I don't use"
    enabled     = true
  }
  
  rules {
    action      = "managed_challenge"
    expression  = <<EOF
    (
      starts_with(http.host, "foobar")
      and (http.request.method eq "GET")
      and (http.request.uri.query ne "")
      and (http.request.uri.path in { ${join(" ", local.paths_to_protection)} } )
    )
    EOF
    description = "Testing query parameter pollution on a single subdomain"
    enabled     = true
  }

  rules {
    action      = "managed_challenge"
    expression  = <<EOF
                (
                    http.request.uri.path contains "/posts/"
                    and not any(lower(http.request.headers.names[*])[*]
                    contains "authorization")
                    and ip.geoip.country in { ${join(" ", var.my_markets)} }
                )
    EOF
    description = "Challenge requests that don't send authorization header from known country"
    enabled     = true
  }

  rules {
    action      = "block"
    expression  = <<EOF
                (
                    http.request.uri.path contains "/"
                    and (any(http.request.headers["foo"][*] == "bar"))

                )
    EOF
    description = "Block requests that pass \"foo=bar\" Header"
    enabled     = true
  }

  rules {
    action      = "block"
    expression  = <<EOF
                (
                    http.request.uri.path contains "/"
                    and (any(lower(http.request.headers.names[*])[*] == "foo-id"))
                )
    EOF
    description = "Block requests that pass \"foo-id\" Header value, regardless of value"
    enabled     = true
  }
}
