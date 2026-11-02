# env variable: TF_VAR_rustymagnet_zone_id    ( case sensitive )
variable "rustymagnet_zone_id" {
  description = "Zone ID for rustymagnet.xyz, read from TF env vars"
  type        = string
  default     = ""
}

variable "challenged_markets_list" {
  description = "Country codes challenged by the firewall ruleset"
  type        = list(string)
  default = [
    "GB",
    "KP",
    "PK",
    "RU",
    "SO",
    "SY",
  ]
}
