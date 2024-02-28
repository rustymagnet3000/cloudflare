resource "cloudflare_ruleset" "homepage_to_worker" {
  zone_id     = var.xyz_zone_id
  description = "Redirects ruleset"
  name        = "redirects from /promo/ to Blog post 1"
  phase       = "http_request_dynamic_redirect"
  kind        = "zone"

  rules {
    action = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          expression = "concat(\"https://\", http.host, \"/foo\", http.request.uri.path)"
        }
        preserve_query_string = true
      }
    }
    expression  = <<EOF
    (
        http.request.method eq "GET"
        and (http.request.uri.path eq "/promo/")
    )
    EOF
    description = "Redirect visitor from ${var.xyz_zone_name}/promo/ to Blog Post 1"
    enabled     = true
  }
}
