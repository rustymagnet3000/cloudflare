# Temporary: moves transform_rules out of the root state into its own stack.
#
# These blocks tell Terraform to forget the resources WITHOUT destroying them.
# The matching import blocks live in transform_rules/imports.tf.
#
# Delete this file once `terraform apply` has been run here and in
# transform_rules/, and both plans report no changes.

removed {
  from = module.transform_rules.cloudflare_ruleset.add_request_headers

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.transform_rules.cloudflare_ruleset.response_headers_transforms

  lifecycle {
    destroy = false
  }
}
