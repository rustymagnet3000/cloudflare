resource "cloudflare_ruleset" "my_zone_custom_firewall" {
  zone_id     = var.xyz_zone_id
  name        = "my_firewall_rules_inside_ruleset"
  description = "Zone firewall rules"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [{
    action     = "block"
    expression = <<EOF
    (
      http.request.uri.path.extension in { "php" "jsp" "cgi" }
    )
    EOF

    description = "Block any requests with php jsp cgi extensions "
    enabled     = true
    },
    {
      action      = "managed_challenge"
      expression  = <<EOF
    (
      starts_with(http.host, "foobar")
      and (http.request.method eq "GET")
      and (http.request.uri.query ne "")
      and (http.request.uri.path in { ${join(" ", local.paths_to_protection)} } )
    )
    EOF
      description = "Challenge any request with query parameters to certain paths"
      enabled     = true
    },
    {
      action      = "managed_challenge"
      expression  = <<EOF
    (
        http.request.uri.path contains "/posts/"
        and not any(lower(http.request.headers.names[*])[*] contains "authorization")
        and not ( ip.geoip.country in { ${var.challenged_markets} } )
    )
    EOF
      description = "Challenge requests that don't send authorization header from known country"
      enabled     = true
    },
    # "message": "not entitled: the use of field cf.bot_management.score is not allowed, a Bot Management plan is required",
    # {
    #   action      = "managed_challenge"
    #   expression  = <<EOT
    #             (
    #                 http.request.uri.path eq "/"
    #                 and ( cf.bot_management.score le 29 )
    #             )
    # EOT
    #   description = "Challenge requests with Likely Automated Bot Score"
    #   enabled     = true
    # },
    {
      action      = "block"
      expression  = <<EOF
                (
                    http.request.uri.path eq "/"
                    and (any(http.request.headers["foo"][*] == "bar"))

                )
    EOF
      description = "Block request to landing page if Header equals \"foo=bar\""
      enabled     = true
    },

    # Key is auto lowered by CF. But need lower() to lowercase the value field
    # header presence. lower() is not required for the "key". CF auto handles this
    {
      action      = "block"
      expression  = <<EOT
                (
                    http.request.uri.path contains "/"
                    and (any(lower(http.request.headers.names[*])[*] == "foo-id"))
                )
    EOT
      description = "Block requests that pass \"foo-id\" Header value, regardless of value"
      enabled     = true
    }
  ]



}
