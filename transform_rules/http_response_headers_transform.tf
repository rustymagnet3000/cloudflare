resource "cloudflare_ruleset" "response_headers_transforms" {
  zone_id     = var.rustymagnet_zone_id
  name        = "Transform Response before it hits server"
  description = "Transform response or response headers"
  kind        = "zone"
  phase       = "http_response_headers_transform"
  rules       = []
}
