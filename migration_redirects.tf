# Temporary: moves redirects out of the root state into its own stack.
#
# Tells Terraform to forget the ruleset WITHOUT destroying it. The matching
# import block lives in redirects/imports.tf.
#
# Delete this file once `terraform apply` has been run here and in
# redirects/, and both plans report no changes.

removed {
  from = module.redirects.cloudflare_ruleset.redirect_promo_to_post_one

  lifecycle {
    destroy = false
  }
}
