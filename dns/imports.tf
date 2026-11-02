# Temporary: adopts the Workers custom domain that already exists in
# Cloudflare into this stack's fresh state file, instead of creating a
# second one.
#
# Delete this file once `terraform apply` has run and the plan is clean.

import {
  to = cloudflare_workers_custom_domain.foo_worker_dns_entry
  id = "${var.cloudflare_account_id}/5a15b3cd3dd5eb6d4ed8528722e21fc3c95d3988"
}
