# env variable: TF_VAR_cloudflare_account_id
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = "Cloudflare Account ID that is read from TF env vars"
}


variable "list_id" {
  description = "ID of Cloudflare List"
  type        = string
  default     = "c6bba31b2035423f9a65f2e9ff5dec46"
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