# removed {
#   from = cloudflare_bot_management.bot_settings
#   lifecycle {
#     destroy = false
#   }
# }

import {
  for_each = local.cloudflare_domains_map
  to       = cloudflare_bot_management.bot_settings[each.key]
  id       = each.value
}


resource "cloudflare_bot_management" "bot_settings" {
  for_each               = local.zones_under_bot_management
  zone_id                = local.cloudflare_domains_map[each.key]
  ai_bots_protection     = each.value.ai_bots_protection
  crawler_protection     = each.value.crawler_protection
  enable_js              = each.value.enable_js
  fight_mode             = each.value.fight_mode
  bm_cookie_enabled      = each.value.bm_cookie_enabled
  optimize_wordpress     = each.value.optimize_wordpress
  is_robots_txt_managed  = each.value.is_robots_txt_managed
  auto_update_model      = each.value.auto_update_model
  suppress_session_score = null

  # robots.txt AI preferences, published by bot_preference_sync_enabled
  ai_training                 = each.value.ai_training
  ai_user                     = each.value.ai_user
  aisearch                    = each.value.aisearch
  bot_preference_sync_enabled = each.value.bot_preference_sync_enabled
}
