# env variable: TF_VAR_cloudflare_account_id    ( case sensitive )
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID, read from TF env vars"
  type        = string
  default     = ""
}

# env variable: TF_VAR_rustymagnet_zone_id    ( case sensitive )
variable "rustymagnet_zone_id" {
  description = "Zone ID for rustymagnet.xyz, read from TF env vars"
  type        = string
  default     = ""
}
