# Both of these are left over from resources that used to live in this stack.
#
# Whether either is still needed cannot be established while the zone state
# will not decode -- see imports.tf. Once `terraform plan` runs clean, check
# `terraform state list` and delete whichever addresses are no longer present.
# Assuming a removed block was spent is how #80 went wrong on lists.

removed {
  from = cloudflare_bot_management.bot_settings

  lifecycle {
    destroy = false
  }
}

removed {
  from = cloudflare_zone_setting.overrides

  lifecycle {
    destroy = false
  }
}
