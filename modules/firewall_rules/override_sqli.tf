# works on Enterprise account but not Free account
# Cloudflare expects the Expression field to contain N amount of "allowed" paths rather than multiple rulesets doing the SQLi overrides
# if you add a similiar file, the "apply" stage will fail with " a similar configuration with rules already exists"
# efb7b8c949ac4650a09736fc376e9aee is the public ID of the Cloudflare Managed Ruleset
# SQL Rule IDs found at:
# curl "https://api.cloudflare.com/client/v4/zones/{Zone ID}/rulesets/efb7b8c949ac4650a09736fc376e9aee/versions/{VERSION ID}" \
#      -H 'Authorization: Bearer < personal CF token>' 

# resource "cloudflare_ruleset" "sql-allowed-override" {
#   zone_id     = var.xyz_zone_id
#   name        = "WAF override SQL queries"
#   description = "Example override"
#   kind        = "zone"
#   phase       = "http_request_firewall_managed"

#   rules {
#     action = "skip"
#     action_parameters {
#       rules = {
#         "efb7b8c949ac4650a09736fc376e9aee" = "98f746d07a6d48ab9dae669acb5d0b9b, 8629bb58defe4193ab4d493c7bd2d8fa,e3a567afc347477d9702d9047e97d760,8166da327a614849bfa29317e7907480,7aeaab585dac470097448f991c8e7f7f"
#       }
#     }
#     # add Paths to service in the expression 
#     # no need for hostname, as this rule is only deployed on a single zone
#     expression  = <<EOF
#                 (
#                     http.request.uri.path contains "foobar/"
#                     and (http.request.method eq "POST")
#                 )
#                 EOF
#     description = "WAF override that allow SQL queries to be sent to endpoint(s)"
#     enabled     = true
#   }
# }
