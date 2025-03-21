locals {
  securityHeaders = jsondecode(file("security_headers.json"))

  zone_settings = {
    "security_level"   = "medium",
    "always_use_https" = "on",
    "min_tls_version"  = "1.2",
    "tls_1_3"          = "on",
    "ssl"              = "strict",
    # "true_client_ip_header" = "off", not editable in free plan
    "max_upload"          = 100,
    "replace_insecure_js" = "off",
    "security_header"     = local.securityHeaders.value

  }

}





