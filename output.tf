output "rm_cloudflare_account_id" {
  value = var.rm_cloudflare_account_id
}

# child module
output "child_cloudflare_account_id_access_rules" {
  value = module.access_rules.ar_cf_account_id
}

# output.tf
output "debugging_burgers" {
  value = [for i, v in var.burger_ingrediant_list : "${i} is ${v}"]
}



