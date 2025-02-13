resource "null_resource" "example" {

  provisioner "local-exec" {

    command = "echo Hello World!"

  }

}


resource "cloudflare_account_member" "root_account_member" {
  account_id    = var.cloudflare_account_id
  email_address = var.email_of_root_cf_user
  role_ids = [
    "33666b9c79b9a5273fc7344ff42f953d"  # super admin
  ]
}