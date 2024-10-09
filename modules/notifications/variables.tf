variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"

  type    = string
  default = ""
}

# comes from Root module
variable "email_for_notifications" {
  description = "Email of Cloudflare interested parties"

  type    = string
  default = ""
}
