variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}

variable "paths_to_protect" {
  type = list(string)
  default = [
    "\"/login\"",
     "\"/post\"",
  ]
}

variable "xyz_zone_id" {
  description = "Zone ID passed from root Module"
  type        = string
  default     = ""
}

variable "website" {
  description = "Name of website from Zone data source in Root module"
  type        = string
  default     = ""
}
