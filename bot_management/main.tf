resource "cloudflare_bot_management" "bot_settings" {
  for_each               = local.zones_under_bot_management
  zone_id                = local.cloudflare_domains_map[each.key]
  ai_bots_protection     = each.value.ai_bots_protection
  crawler_protection     = each.value.crawler_protection
  enable_js              = each.value.enable_js
  fight_mode             = each.value.fight_mode
  suppress_session_score = null
}
