# env variable: TF_VAR_cloudflare_account_id
# case sensitive !
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = ""
}

# env variable: TF_VAR_rm_emails_for_notifications is array of emails ["foo@bar.com"]
variable "rm_emails_for_notifications" {
  description = "Email of Cloudflare interested parties"

  type    = list(string)
  default = []
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
    "NZ",
    "AU",
    "FR",
    "GB",
  ]
}

# env variable: TF_VAR_rm_home_ip_address
variable "rm_home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}
