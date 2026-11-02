# env variable: TF_VAR_cloudflare_account_id    ( case sensitive )
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID, read from TF env vars"
  type        = string
  default     = ""
}

# env variable: TF_VAR_rm_home_ip_address    ( case sensitive )
variable "rm_home_ip_address" {
  description = "Home IP address to whitelist, read from TF env vars"
  type        = string
  default     = ""
}

variable "countries_to_challenge" {
  description = "Countries served a managed challenge, keyed by label. The id is the existing Cloudflare access rule, used by imports.tf."

  type = map(object({
    country_code = string
    id           = string
  }))

  default = {
    "Russia" = {
      country_code = "RU"
      id           = "98017b76b32f4ee8b76220e5bfa75b93"
    }
    "Kiwis" = {
      country_code = "NZ"
      id           = "20c8f7d7a58d4557b9c594e6db1d5543"
    }
  }
}
