output "zone_rate_limit" {
  value = data.cloudflare_rulesets.rate_limit_info.rulesets
  description = "Output of rulesets related to Rate Limits"
}