output "zone_info" {
  value       = "id:${data.cloudflare_zone.rustymagnet_zone.zone_id}\nstatus:${data.cloudflare_zone.rustymagnet_zone.status}"
  description = "Zone Info"
}

output "zone_settings" {
  value       = { for k, v in local.zone_settings : k => v }
  description = "Zone Info"
}
