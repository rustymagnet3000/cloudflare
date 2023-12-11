output "zone_rate_limit" {
  #value = "Rate Limit ID: ${data.cloudflare_rulesets.rate_limit_info}"
  value = data.cloudflare_rulesets.rate_limit_info.rulesets
}