variable "xyz_zone_id" {
  description = "Zone ID passed from root Module"
  type        = string
  default     = ""
}

variable "cloudflare_token" {
  description = "Cloudflare API Token for Access Rules"
  type        = string
  default     = ""
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "countries_naughty_map" {
  type    = map(any)
  default = {}
}

variable "home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}