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

resource "cloudflare_zone" "rustymagnet_com" {
  account = {
    id = var.cloudflare_account_id
  }
  name = "rustymagnet.com"
  type = "full"

  lifecycle {
    prevent_destroy = true
  }
}
