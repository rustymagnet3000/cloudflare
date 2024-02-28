resource "cloudflare_ruleset" "homepage_to_worker" {
  zone_id     = var.xyz_zone_id
  description = "Redirects ruleset"
  name        = "redirects from landing page to Blog 1"
  phase       = "http_request_dynamic_redirect"
  kind        = "zone"

  rules {
    action = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = "/posts/my-first-post/"
        }
        preserve_query_string = false
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
