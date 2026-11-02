locals {
  cloudflare_domains_map = {
    for zone in data.cloudflare_zones.all_rm_zones :
    zone.name => join(", ", zone.result[*].id)
  }

  # Stance: block training, stay readable.
  #
  #   ai_training = "block"   do not harvest these posts to train a model
  #   ai_user     = "disabled"  an assistant fetching a page because someone
  #                             asked about it is a reader, so let it through
  #   aisearch    = "disabled"  blocking AI search would delist the blog from
  #                             the places people now search
  #
  # bot_preference_sync_enabled publishes those three in robots.txt;
  # is_robots_txt_managed is what makes Cloudflare serve a robots.txt at all.
  # ai_bots_protection is the edge enforcement behind the declaration.
  #
  # crawler_protection stays off: a link maze costs crawl budget on a small
  # blog and buys little.
  bot_defaults = {
    ai_bots_protection          = "block"
    ai_training                 = "block"
    ai_user                     = "disabled"
    aisearch                    = "disabled"
    bot_preference_sync_enabled = true
    is_robots_txt_managed       = true
    auto_update_model           = true
    bm_cookie_enabled           = true
    crawler_protection          = "disabled"
    enable_js                   = false
    fight_mode                  = false
    optimize_wordpress          = false
  }

  zones_under_bot_management = {
    "rustymagnet.xyz" = local.bot_defaults
    "rustymagnet.com" = local.bot_defaults
  }
}
