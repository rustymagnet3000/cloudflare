variable "domain" {
  default = "rustymagnet.xyz"
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

# env variable: TF_VAR_rm_cloudflare_token
variable "rm_cloudflare_token" {
  description = "Cloudflare API Token"

  type    = string
  default = ""
}

