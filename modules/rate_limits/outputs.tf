output "zone_rate_limit" {
  value       = data.cloudflare_rulesets.rate_limit_info.account_id
  description = "Output of rulesets related to Rate Limits"
}