data "cloudflare_api_token_permissions_groups" "all" {
    account_id = var.cloudflare_account_id
}
