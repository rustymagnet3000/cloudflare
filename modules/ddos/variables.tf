# env variable: TF_VAR_cloudflare_zone_id
variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for .xyz"

  type    = string
  default = ""
}

# env variable: TF_VAR_cloudflare_ruleset_id
variable "cloudflare_ruleset_id" {
  description = "Cloudflare Account ID for Access Rules"

  type    = string
  default = ""
}
