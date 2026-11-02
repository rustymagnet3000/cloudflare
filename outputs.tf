output "account_info" {
  value       = data.cloudflare_account.rm_account.name
  description = "Cloudflare Account Info"
}

output "southern_european_markets" {
  value       = join(" ", local.southern_european_markets)
  description = "Join southern european countries"
}
