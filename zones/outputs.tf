output "zone_ids" {
  value       = local.zone_ids
  description = "Zone name to zone ID, for every zone this stack manages"
}

output "zone_info" {
  value       = <<-EOT
  name:   ${data.cloudflare_zone.rustymagnet_zone.name}
  id:     ${data.cloudflare_zone.rustymagnet_zone.zone_id}
  status: ${data.cloudflare_zone.rustymagnet_zone.status}
  EOT
  description = "Name, ID and status of rustymagnet.xyz"
}

output "managed_zone_settings" {
  value = concat(
    keys(local.zone_settings_string),
    keys(local.zone_settings_number),
    ["security_header"],
  )
  description = "Setting IDs this stack manages, applied to every zone above"
}

output "strict_transport_security" {
  value = format("enabled: %s, sub-domains: %s, max-age: %s",
    local.security_headers.value.strict_transport_security.enabled,
    local.security_headers.value.strict_transport_security.include_subdomains,
    local.security_headers.value.strict_transport_security.max_age,
  )
  description = "HSTS as declared in security_headers.json"
}
