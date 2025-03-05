# env variable: TF_VAR_cloudflare_account_id
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = "Cloudflare Account ID that is read from TF env vars"
}


variable "list_id" {
  description = "ID of Cloudflare List"
  type        = string
  default     = "e9f8cbe92185402e98d2e08a708b9c9d"
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
      comment    = "han's IP's"
      id         = "61d81361642a4f56968b225a374b7b16"
    }
    "luke" = {
      ip_address = "192.168.2.160/27"
      comment    = "luke's IP range"
      id         = "8a5b53ed7c46479c903d07feb42706de"
    }
    "r2d2" = {
      ip_address = "192.168.0.2"
      comment    = "r2d2's IP range",
      id         = "c06aaaf99fbd41a68536c9753fbba04a"
    }
    "vadar" = {
      ip_address = "192.168.0.1"
      comment    = "vadar's home IP",
      id         = "70f2ec597cc545cca1395fe8e2e05dbe"
    }
  }
}