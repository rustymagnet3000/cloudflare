# not Advanced Rate Limit as no counting expression

resource "cloudflare_ruleset" "zone_rl_custom_response" {
  zone_id     = var.xyz_zone_id
  name        = "Basic Rate Limit for my zone"
  description = ""
  kind        = "zone"
  phase       = "http_ratelimit"

  rules {
    action = "block"
    action_parameters {
      response {
        status_code  = 429
        content      = "{\"response\": \"block\"}"
        content_type = "application/json"
      }
    }
    ratelimit {
      characteristics     = ["ip.src", "cf.colo.id"]
      period              = 10
      requests_per_period = 5
      requests_to_origin  = false
      mitigation_timeout  = 10 # free plan has to use 10
    }
    # the following expression can't use HTTP Response Code, http.host or Request Method
    expression  = <<EOF
        (
            and http.request.uri.path in { ${join(" ", var.paths_to_protect)} }
        )
        EOF
    description = "Rate limit requests to ${var.website}"
    enabled     = true
  }
}
