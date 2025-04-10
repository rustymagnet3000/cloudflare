# env variable: TF_VAR_cloudflare_account_id
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = "Cloudflare Account ID that is read from TF env vars"
}

# env variable: TF_VAR_rustymagnet_zone_id    ( case sensitive )
variable "rustymagnet_zone_id" {
  type    = string
  default = ""
}
