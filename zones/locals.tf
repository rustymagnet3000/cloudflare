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


output "security_settings" {
  value = {
    sts = format("strict_transport_security | enabled: %s\nstrict_transport_security sub-domains | enabled: %s\n", 
    local.securityHeaders.value.strict_transport_security.enabled,
    local.securityHeaders.value.strict_transport_security.include_subdomains
    )
  }
}



