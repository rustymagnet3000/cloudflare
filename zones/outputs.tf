output "zone_info" {
  value       = <<-EOT
  name:   ${data.cloudflare_zone.rustymagnet_zone.name}
  id:     ${data.cloudflare_zone.rustymagnet_zone.zone_id}
  status: ${data.cloudflare_zone.rustymagnet_zone.status}  
  EOT
  description = "Zone Info"
}

output "raw_data_source_zones" {
  value = data.cloudflare_zones.all_rm_zones
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


output "zone_id_from_original_data_source_map" {
  value       = one(data.cloudflare_zones.all_rm_zones["rustymagnet.com"].result).id
  description = "rustymagnet.com Zone ID"
}

output "zone_ids_from_original_data_source_map_v2" {
  value = [for v in data.cloudflare_zones.all_rm_zones : v.result[0].id]
}

