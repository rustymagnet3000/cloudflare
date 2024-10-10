
# resource "cloudflare_api_token" "logpush_r2_token" {
#   name = "logpush_r2_token"
#   policy = [{
#     permission_groups = [
#       data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"],
#     ]
#     resources = {
#       "com.cloudflare.api.account.*" = "*"
#     }
#   }]
# }

