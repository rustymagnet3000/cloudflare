variable "xyz_zone_id" {
  description = "Zone ID passed from root Module"
  type        = string
  default     = ""
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "challenged_markets" {
  type    = string
  default = ""
}

variable "allow_list_id" {
  type    = string
  default = "string ID of IP allow list"
}

variable "allowed_ips" {
  type = map(object({
    ip_address = string
    comment    = string
    id         = string
  }))

  default = {}
}
