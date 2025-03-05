# env variable: TF_VAR_cloudflare_account_id
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = ""
}

# env variable: TF_VAR_rustymagnet_zone_id
variable "rustymagnet_zone_id" {
  type    = string
  default = ""
}
