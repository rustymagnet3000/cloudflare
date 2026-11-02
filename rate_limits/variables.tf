# env variable: TF_VAR_rustymagnet_zone_id    ( case sensitive )
variable "rustymagnet_zone_id" {
  description = "Zone ID for rustymagnet.xyz, read from TF env vars"
  type        = string
  default     = ""
}

variable "paths_to_protect" {
  description = "Quoted URI paths the basic rate limit applies to"
  type        = list(string)
  default = [
    "\"/login\"",
    "\"/post\"",
  ]
}
