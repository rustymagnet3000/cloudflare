variable "xyz_zone_id" {
  description = "Zone ID passed from root Module"
  type        = string
  default     = ""
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "my_markets" {
  type    = list(string)
  default = []
}