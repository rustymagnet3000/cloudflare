variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "su_email_for_notifications" {
  description = "Email of Cloudflare interested parties"

  type    = string
  default = ""
}
