# Temporary: three resources collapsed into cloudflare_zone_setting.settings.
#
# Without these, Terraform reads the old addresses as orphans and plans a
# destroy for every zone setting, which reverts each one to the Cloudflare
# default -- ssl, min_tls_version and always_use_https included, on both live
# zones. That plan read "16 to add, 0 to change, 16 to destroy".
#
# These are per-instance rather than two wholesale moves because Terraform
# allows only one moved source per destination resource:
#
#   Error: Ambiguous move statements
#   Each resource can have moved from only one source resource.
#
# moved blocks take no for_each, so all 16 are written out.
#
# Deleted once in #98 before the moves had been applied. Do not delete it again
# until `terraform state list` here shows cloudflare_zone_setting.settings[...]
# and none of string_settings, number_settings or security_header.

moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.xyz|always_use_https"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|always_use_https"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.xyz|min_tls_version"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|min_tls_version"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.xyz|replace_insecure_js"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|replace_insecure_js"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.xyz|security_level"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|security_level"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.xyz|ssl"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|ssl"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.xyz|tls_1_3"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|tls_1_3"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.com|always_use_https"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|always_use_https"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.com|min_tls_version"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|min_tls_version"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.com|replace_insecure_js"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|replace_insecure_js"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.com|security_level"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|security_level"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.com|ssl"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|ssl"]
}
moved {
  from = cloudflare_zone_setting.string_settings["rustymagnet.com|tls_1_3"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|tls_1_3"]
}
moved {
  from = cloudflare_zone_setting.number_settings["rustymagnet.xyz|max_upload"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|max_upload"]
}
moved {
  from = cloudflare_zone_setting.number_settings["rustymagnet.com|max_upload"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|max_upload"]
}
moved {
  from = cloudflare_zone_setting.security_header["rustymagnet.xyz"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|security_header"]
}
moved {
  from = cloudflare_zone_setting.security_header["rustymagnet.com"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|security_header"]
}
