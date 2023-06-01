# resource "cloudflare_ruleset" "rm_account_level_ddos" {
#   zone_id     = var.cloudflare_zone_id
#   name        = "override user_agent from \"log\" to \"managed_challenge\""
#   description = ""
#   kind        = "zone"
#   phase       = "ddos_l7"

#   rules {
#     action = "execute"
#     action_parameters {
#       # https://api.cloudflare.com/client/v4/zones/<zoneid>/rulesets
#       # "name": "DDoS L7 ruleset",
#      id = var.cloudflare_ruleset_id

#       overrides {
#         rules {
#           # Rule: User-Agent-aware DDoS Protection 
#           # this ID is not account specific. It is univeral to all Cloudflare customers ( and public info ).
#           id                = "7709d496081e458899c1e3a6e4fe8e55"
#           sensitivity_level = "medium"
#           action            = "managed_challenge"
#         }
#       }
#     }
#     expression  = "true"
#     description = "Override the current default (\"log\") for the User-Agent-aware DDoS Protection rule"
#     enabled     = true
#   }
# }
