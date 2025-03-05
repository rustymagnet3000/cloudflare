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

variable "countries_to_challenge" {
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


variable "allowed_ips" {
  type = map(object({
    ip_address = string
    comment    = string
    id         = string
  }))

  default = {
    "han" = {
      ip_address = "192.168.1.128/25"
      comment    = "one"
      id         = "61d81361642a4f56968b225a374b7b16"
    }
    "luke" = {
      ip_address = "192.168.0.160/27"
      comment    = "two"
      id         = "8a5b53ed7c46479c903d07feb42706de"
    }
    "r2d2" = {
      ip_address = "192.168.0.160/27"
      comment    = "duplicate comment",
      id         = "c06aaaf99fbd41a68536c9753fbba04a"
    }
    "vadar" = {
      ip_address = "192.168.0.160/27"
      comment    = "duplicate comment",
      id         = "70f2ec597cc545cca1395fe8e2e05dbe"
    }
  }
}