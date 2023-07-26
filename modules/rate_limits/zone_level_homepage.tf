# # not entitled: there are 2 errors: the use of field http.host is not allowed, the use of
# # │ field http.request.method is not allowed, an higher Advanced Rate Limiting plan is
# # │ required

# resource "cloudflare_ruleset" "zone_rl_custom_response" {
#   zone_id     = var.xyz_zone_id
#   name        = "Advanced rate limiting rule for my zone"
#   description = ""
#   kind        = "zone"
#   phase       = "http_ratelimit"

#   rules {
#     action = "block"
#     action_parameters {
#       response {
#         status_code = 429
#         content = "{\"response\": \"block\"}"
#         content_type = "application/json"
#       }
#     }
#     ratelimit {
#       characteristics = ["ip.src", "cf.colo.id"]
#       period = 10
#       requests_per_period = 5
#       mitigation_timeout = 30
#       counting_expression = <<EOF
#                 (
#                     http.host contains "${var.website}"
#                     and (http.request.method eq "POST")
#                     and (http.request.uri.path contains "/foobar")
#                     and (http.response.code eq 404)
#                 )
#                 EOF      
#     }
#     # the following expression can't use HTTP Response Code
#     expression = <<EOF
#                 (
#                     http.host contains "${var.website}"
#                     and (http.request.method eq "POST")
#                     and (http.request.uri.path contains "/foobar")
#                 )
#                 EOF
#     description = "Rate limit requests to ${var.website}"
#     enabled = true
#   }
# }