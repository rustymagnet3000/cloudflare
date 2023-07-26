#  Error: error creating ruleset Account level rate limits
# │ not entitled to create custom rulesets

# resource "cloudflare_ruleset" "foobar_advanced_rate_limit_acc_level" {
#   account_id  = var.cloudflare_account_id
#   name        = "Account level rate limits"
#   description = ""
#   kind        = "custom"
#   phase       = "http_ratelimit"

#   rules {
#     action = "log"
#     ratelimit {
#       characteristics = ["ip.src", "cf.colo.id"]
#       period = 10
#       requests_per_period = 5
#       mitigation_timeout = 30
#     }
#     expression = <<EOF
#                 (
#                     http.host contains "${var.website}"
#                     and (http.request.method eq "POST")
#                     and (http.request.uri.path contains "/foobar")
#                 )
#                 EOF
#     description = "Advanced Rate limit for consumer graphql POST service"
#     enabled = true
#   }
# }