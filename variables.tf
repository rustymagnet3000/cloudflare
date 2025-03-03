# env variable: TF_VAR_cloudflare_account_id    ( case sensitive )
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = ""
}

# env variable: TF_VAR_rustymagnet_zone_id    ( case sensitive )
variable "rustymagnet_zone_id" {
  type    = string
  default = ""
}

# env variable: TF_VAR_email_of_root_cf_user
variable "email_of_root_cf_user" {
  description = "Email of Cloudflare interested parties"

  type    = string
  default = ""
}

variable "countries_naughty_map" {
  type = map(any)
  default = {
    "Kiwis"  = "NZ"
    "Russia" = "RU"
  }
}

variable "challenged_markets_list" {
  type = list(string)
  default = [
    "GB",
    "KP",
    "PK",
    "RU",
    "SO",
    "SY",
  ]
}


# env variable: TF_VAR_rm_home_ip_address
variable "rm_home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}
