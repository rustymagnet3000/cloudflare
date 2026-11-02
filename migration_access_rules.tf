# Temporary: moves access_rules out of the root state into its own stack.
#
# Tells Terraform to forget the rules WITHOUT destroying them. The matching
# import blocks live in access_rules/imports.tf. Apply access_rules/ first,
# so the rules are adopted before the root module lets go of them.
#
# Delete this file once `terraform apply` has been run here and in
# access_rules/, and both plans report no changes.

removed {
  from = module.access_rules.cloudflare_access_rule.countries_to_challenge

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.access_rules.cloudflare_access_rule.home_whitelist

  lifecycle {
    destroy = false
  }
}
