
# can't import cloudflare_zone_settings_override: https://github.com/cloudflare/terraform-provider-cloudflare/issues/377

# resource "cloudflare_zone_settings_override" "zone_setting_overrides" {
#   zone_id = cloudflare_zone.xyz.id
#   settings =[ {
#     always_use_https         = "on"
#     automatic_https_rewrites = "on"
#     security_level           = "medium"
#     ssl                      = "full"
#     min_tls_version          = "1.2"
#     tls_1_3                  = "on"
#     # true_client_ip_header    = "off"  not "editable" in free plan
#   }]
# }