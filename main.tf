import {
  id = "${var.cloudflare_account_id}/b3e5edb2c6248b103512217dd6563a72"
  to = cloudflare_account_member.root_account_member
}

import {
  for_each = var.countries_to_challenge
  to       = module.access_rules.cloudflare_access_rule.countries_to_challenge[each.key]
  id       = "accounts/${var.cloudflare_account_id}/${each.value.id}"
}


resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo Hello World!"
  }
}


resource "cloudflare_account_member" "root_account_member" {
  account_id = var.cloudflare_account_id
  email      = var.email_of_root_cf_user
  roles = [
    "33666b9c79b9a5273fc7344ff42f953d" # super admin
  ]
}