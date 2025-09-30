locals {
  cloudflare_domains_map = {
    for zone in data.cloudflare_zones.all_rm_zones :
    zone.name => join(", ", zone.result[*].id)
  }
  zones_under_bot_management = {
    "rustymagnet.xyz" = {
      ai_bots_protection    = "disabled"
      crawler_protection    = "disabled"
      fight_mode            = false
      enable_js             = false
      is_robots_txt_managed = false
      auto_update_model     = true
      bm_cookie_enabled     = true
      optimize_wordpress    = false
    }
    "rustymagnet.com" = {
      ai_bots_protection    = "disabled"
      crawler_protection    = "disabled"
      fight_mode            = false
      enable_js             = false
      is_robots_txt_managed = false
      auto_update_model     = true
      bm_cookie_enabled     = true
      optimize_wordpress    = false
    }
  }
}
