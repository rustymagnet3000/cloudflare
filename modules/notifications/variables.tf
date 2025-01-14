variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"

  type    = string
  default = ""
}

# comes from Root module
variable "emails_for_notifications" {
  description = "Email of Cloudflare interested parties"

  type      = list(string)
  default   = []
}
