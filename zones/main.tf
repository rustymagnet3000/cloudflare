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

  # Deleting this zone takes its DNS records with it and cannot be undone.
  # Terraform will refuse any plan that destroys or replaces it until this
  # block is removed deliberately.
  lifecycle {
    prevent_destroy = true
  }
}
