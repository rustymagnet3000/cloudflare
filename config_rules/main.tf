resource "cloudflare_ruleset" "http_config_rules_example" {
  zone_id     = var.rustymagnet_zone_id
  name        = "Config rules ruleset"
  description = "Set configuration rules for incoming requests"
  kind        = "zone"
  phase       = "http_config_settings"

  rules = [
    {
      ref         = "enable_fonts"
      description = "Swap out Google Fonts for Fonts from Origin"
      expression  = "(http.request.uri.path contains \"^/foobar/\")"
      action      = "set_config"
      action_parameters = {
        fonts = true
      }
    }
  ]
}
