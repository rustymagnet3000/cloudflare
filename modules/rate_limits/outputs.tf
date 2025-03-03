output "zone_rate_limit" {
  value       = data.cloudflare_rulesets.rate_limit_info
  description = "Output of rulesets related to Rate Limits"
}