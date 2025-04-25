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

variable "rustymagnet_zones_set" {
  type        = list(string)
  description = "A list of Rusty Magnet's domains. Used by data_sources.tf for dynamic lookups of zone_ids"
  default = [
    "rustymagnet.com",
    "rustymagnet.xyz",
  ]
}