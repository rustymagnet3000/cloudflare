# expression field not allowed in free tier
resource "cloudflare_ruleset" "deliveroo_ddos_overrides" {
  zone_id     = var.xyz_zone_id
  name        = "Zone level DDOS overrides"
  description = "Rules that override the default DDOS Managed Rules from Cloudflare"
  kind        = "zone"
  phase       = "ddos_l7"

  rules {
    action = "execute"
    action_parameters {
      id = "4d21379b4f9f4bb088e0729962c8b3cf" # "DDoS L7 ruleset [ this is a common ID value ]"
      overrides {
        rules {
          id                = "cc5ac300fbc54ceda2944ca261bc58d5" #"HTTP requests with unusual HTTP headers or URI path (signature #55)."
          sensitivity_level = "medium"
          action            = "managed_challenge"
        }
      }
    }
    expression  = true
    description = "Override the HTTP DDoS Attack Protection managed ruleset"
    enabled     = true
  }
}
