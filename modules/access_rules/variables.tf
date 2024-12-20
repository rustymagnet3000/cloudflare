variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "countries_naughty_map" {
  type        = map(any)
  description = "A map of countries to Block or Challenge"
  default     = {}
}

variable "home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}