data "cloudflare_zone" "xyz" {
  name = "rustymagnet.xyz"
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

variable "burger_ingrediant_list" {
  type        = list(string)
  description = "A list of all Burger ingrediants"
  default     = ["cheese", "bacon", "lettuce", "burger", "relish"]
}


variable "my_zones" {
  type        = list(string)
  description = "A list of my zones"
  default     = ["rustymagnet.xyz"]
}
