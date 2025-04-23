output "zone_info" {
  value       = <<-EOT
  name:   ${data.cloudflare_zone.rustymagnet_zone.name}
  id:     ${data.cloudflare_zone.rustymagnet_zone.zone_id}
  status: ${data.cloudflare_zone.rustymagnet_zone.status}  
  EOT
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

output "all_zones" {
  value       = { for k, v in local.cloudflare_domains_map : k => v }
  description = "All Zones from dynamic lookup"
}

output "all_zones_ids" {
  value       = values(local.cloudflare_domains_map)
  description = "Prints all zone ids"
}

output "rustymagnet_com_zone_id" {
  value       = local.cloudflare_domains_map["rustymagnet.com"]
  description = "rustymagnet.com Zone ID"
}

