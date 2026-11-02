# env variable: TF_VAR_cloudflare_account_id
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID, read from TF env vars"
  type        = string
  default     = ""
}


# env variable: TF_VAR_rm_emails_for_notifications is array of emails ["foo@bar.com"]
variable "rm_emails_for_notifications" {
  description = "Email of Cloudflare interested parties"

  type    = list(string)
  default = []
}
