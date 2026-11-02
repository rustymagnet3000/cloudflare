# A basic Rate Limit, not an Advanced one: no counting expression.
# https://developers.cloudflare.com/waf/rate-limiting-rules/
#
# Two things the free plan refused, which is why this rule looks the way it does:
#
#   Account-level ruleset  -> "not entitled to create custom rulesets"
#   http.host / http.request.method / http.response.code in the expression
#                          -> "the use of field http.host is not allowed [...]
#                              an higher Advanced Rate Limiting plan is required"
resource "cloudflare_ruleset" "zone_rl_custom_response" {
  zone_id     = var.rustymagnet_zone_id
  name        = "Basic Rate Limit for my zone"
  description = ""
  kind        = "zone"
  phase       = "http_ratelimit"

  rules = [{
    action = "block"
    action_parameters = {
      response = {
        status_code  = 429
        content      = "{\"response\": \"please slow down\"}"
        content_type = "application/json"
      }
    }
    ratelimit = {
      characteristics     = ["cf.colo.id", "ip.src"]
      period              = 10
      requests_per_period = 5
      # count cached requests in Rate Limit counter as this feature isn't available in Free zones
      requests_to_origin = false
      mitigation_timeout = 10 # free plan has to use 10
    }
    # the following expression can't use HTTP Response Code, http.host or Request Method
    expression  = <<EOF
        (
            http.request.uri.path in { ${join(" ", var.paths_to_protect)} }
        )
        EOF
    description = "Rate limit requests to ${data.cloudflare_zone.website.name}"
    enabled     = true
  }]
}
