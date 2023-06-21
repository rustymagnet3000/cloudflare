variable "xyz_zone_id" {
  description = "Zone ID passed from root Module"
  type        = string
  default     = ""
}

variable "website" {
  description = "Name of website from Zone data source in Root module"
  type        = string
  default     = ""
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}
