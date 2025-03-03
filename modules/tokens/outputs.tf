output "api_tokens_on_cloudflare_account" {
  value       = "${length(data.cloudflare_api_token_permissions_groups.all)} api tokens"
  description = "Number of API Tokens across the Cloudflare account"
}
