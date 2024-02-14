variable "xyz_zone_name" {
  description = "Zone name for xyz passed from root Module"
  type        = string
  default     = ""
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"

  type    = string
  default = ""
}