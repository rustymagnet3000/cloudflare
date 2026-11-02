# Temporary: moves firewall_rules out of the root state into its own stack.
#
# Tells Terraform to forget the ruleset WITHOUT destroying it. The matching
# import block lives in firewall_rules/imports.tf. Apply firewall_rules/ first, so the
# ruleset is adopted before the root module lets go of it.
#
# Delete this file once `terraform apply` has been run here and in
# firewall_rules/, and both plans report no changes.

removed {
  from = module.firewall_rules.cloudflare_ruleset.my_zone_custom_firewall

  lifecycle {
    destroy = false
  }
}
