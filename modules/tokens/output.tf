output "api_tokens_on_cloudflare_account" {
  value = "${length(data.cloudflare_api_token_permission_groups.all)} api tokens"
}
