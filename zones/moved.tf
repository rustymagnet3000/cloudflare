# Temporary: three resources collapsed into cloudflare_zone_setting.settings.
#
# Without these, Terraform reads the old addresses as orphans and plans a
# destroy for every zone setting -- which would revert TLS and HTTPS settings
# on both live zones. The keys for the two for_each resources are unchanged,
# so those move wholesale; security_header was keyed by zone alone and needs
# one block per instance.
#
# No-ops if nothing is in state yet. Delete once `terraform apply` has run and
# the plan is clean.

moved {
  from = cloudflare_zone_setting.string_settings
  to   = cloudflare_zone_setting.settings
}

moved {
  from = cloudflare_zone_setting.number_settings
  to   = cloudflare_zone_setting.settings
}

moved {
  from = cloudflare_zone_setting.security_header["rustymagnet.xyz"]
  to   = cloudflare_zone_setting.settings["rustymagnet.xyz|security_header"]
}

moved {
  from = cloudflare_zone_setting.security_header["rustymagnet.com"]
  to   = cloudflare_zone_setting.settings["rustymagnet.com|security_header"]
}
