data "cloudflare_zone" "website" {
  name = "rustymagnet.xyz"
}


data "cloudflare_list" "ip_list" {
  account_id = var.rm_cloudflare_account_id
  name       = "foo_list"
}


# env variable: TF_VAR_rm_cloudflare_token removed in favor of CLOUDFLARE_API_TOKEN

# env variable: TF_VAR_rm_email_for_notifications
variable "rm_email_for_notifications" {
  description = "Email of Cloudflare interested parties"

  type    = string
  default = ""
}

# env variable: TF_VAR_rm_cloudflare_account_id
variable "rm_cloudflare_account_id" {
  description = "Cloudflare Account ID"

  type    = string
  default = ""
}

variable "countries_naughty_map" {
  type = map(any)
  default = {
    "Aussies" = "AU"
    "Kiwis"   = "NZ"
    "Russia"  = "RU"
  }
}


# env variable: TF_VAR_rm_home_ip_address
variable "rm_home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}





