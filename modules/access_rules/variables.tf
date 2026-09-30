variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "countries_to_challenge" {
  type = map(object({
    country_code = string
    id           = string
  }))

  default = {}
}

variable "home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}
