# Temporary: moves dns out of the root state into its own stack.
#
# Tells Terraform to forget the custom domain WITHOUT destroying it. The
# matching import block lives in dns/imports.tf. Apply dns/ first, so the
# custom domain is adopted before the root module lets go of it.
#
# Delete this file once `terraform apply` has been run here and in dns/, and
# both plans report no changes.

removed {
  from = module.dns.cloudflare_workers_custom_domain.foo_worker_dns_entry

  lifecycle {
    destroy = false
  }
}
