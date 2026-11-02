resource "cloudflare_notification_policy" "dos_attack_l7_notification" {
  account_id  = var.cloudflare_account_id
  name        = "dos_attack_l7 notification"
  description = "Notification policy for dos_attack_l7"
  enabled     = true
  alert_type  = "dos_attack_l7"
  mechanisms = {
    email = [
      for email in var.rm_emails_for_notifications : {
        id = email
      }
    ]
  }
}
