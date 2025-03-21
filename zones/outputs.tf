output "zone_info" {
  value       = "id:${data.cloudflare_zone.rustymagnet_zone.zone_id}\nstatus:${data.cloudflare_zone.rustymagnet_zone.status}"
  description = "Zone Info"
}

output "zone_settings" {
  value       = { for k, v in local.zone_settings : k => v }
  description = "Zone Settings"
}

output "strict_transport_security" {
  value = {
    sts = format("enabled: %s\nsub-domains | enabled: %s\n",
      local.securityHeaders.value.strict_transport_security.enabled,
      local.securityHeaders.value.strict_transport_security.include_subdomains
    )
  }
}
