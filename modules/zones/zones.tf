resource "cloudflare_zone" "xyz" {
  account_id = var.cloudflare_account_id
  zone       = var.xyz_zone_name
}