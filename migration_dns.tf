# Temporary: moves dns out of the root state into its own stack.
#
# Tells Terraform to forget the custom domain WITHOUT destroying it.
#
# NOTE: dns/imports.tf does not exist yet -- the Workers custom domain ID is
# still needed. Do not apply this file until that import block is in place,
# or the custom domain will be left unmanaged by any stack.
#
# Delete this file once `terraform apply` has been run here and in dns/, and
# both plans report no changes.

removed {
  from = module.dns.cloudflare_workers_custom_domain.foo_worker_dns_entry

  lifecycle {
    destroy = false
  }
}
