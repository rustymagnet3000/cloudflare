variable "image_id" {
  default = "default"
}


# env variable: TF_VAR_rm_cloudflare_token removed in favor of CLOUDFLARE_API_TOKEN


variable "all_zone_names" {
  type        = list(string)
  description = "A list of Zones by names. Used as part of data_sources.tf for dynamic zone_id look-up"
  default = [
    "rustymagnet.xyz"
  ]
}

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

variable "my_markets" {
  type = list(string)
  default = [
    "\"NZ\"",
    "\"AU\"",
    "\"FR\"",
    "\"GB\"",
  ]
}


# env variable: TF_VAR_rm_home_ip_address
variable "rm_home_ip_address" {
  description = "Home IP address"

  type    = string
  default = ""
}





