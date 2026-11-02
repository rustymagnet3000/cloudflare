# Temporary: moves rate_limits out of the root state into its own stack.
#
# Tells Terraform to forget the ruleset WITHOUT destroying it. The matching
# import block lives in rate_limits/imports.tf. Apply rate_limits/ first, so the
# ruleset is adopted before the root module lets go of it.
#
# Delete this file once `terraform apply` has been run here and in
# rate_limits/, and both plans report no changes.

removed {
  from = module.rate_limits.cloudflare_ruleset.zone_rl_custom_response

  lifecycle {
    destroy = false
  }
}
