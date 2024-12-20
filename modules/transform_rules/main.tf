resource "cloudflare_ruleset" "add_request_headers" {
  zone_id     = var.xyz_zone_id
  name        = "Transform Rule that adds a HTTP Header to a request before it hits server"
  description = "Injects foo-asn foo-ja3 from the Cloudflare request object"
  kind        = "zone"
  phase       = "http_request_late_transform"
  rules {
    action = "rewrite"
    action_parameters {
      headers {
        name       = "foo-asn"
        operation  = "set"
        expression = "ip.geoip.asnum"
      }
      headers {
        name       = "foo-country"
        operation  = "set"
        expression = "ip.src.country"
      }
      headers {
        name       = "foo-ip"
        operation  = "set"
        expression = "ip.src"
      }
      headers {
        name       = "foo-ray-id"
        operation  = "set"
        expression = "cf.ray_id"
      }
    }
    expression  = "true"
    description = "HTTP Request Header Modification Rule"
    enabled     = true
  }
}
