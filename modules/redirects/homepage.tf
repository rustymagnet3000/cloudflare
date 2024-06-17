resource "cloudflare_ruleset" "redirect_promo_to_post_one" {
  zone_id     = var.xyz_zone_id
  description = "Redirects ruleset"
  name        = "redirects subdomains on ${var.xyz_zone_name}/promo/ to Blog posts/my-first-post/"

  phase = "http_request_dynamic_redirect"
  kind  = "zone"

  dynamic "rules" {
    for_each = toset(local.sites_where_to_place_redirect)
    iterator = subdomain
    content {

      action = "redirect"
      action_parameters {
        from_value {
          status_code = 301
          target_url {
            expression = "concat(\"https://\", http.host, \"/posts/my-first-post/\")"
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
      description = "Redirect visitor from ${subdomain.value}.${var.xyz_zone_name}/promo/ to Blog Post 1"
      enabled     = true
    }
  }
}
