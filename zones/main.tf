removed {
  from = cloudflare_bot_management.bot_settings

  lifecycle {
    destroy = false
  }
}

resource "cloudflare_zone" "rusty_magnet_xyz" {
  account = {
    id = var.cloudflare_account_id
  }
  name = "rustymagnet.xyz"
  type = "full"
}
