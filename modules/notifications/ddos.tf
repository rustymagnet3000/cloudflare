resource "cloudflare_notification_policy" "ddos_notifications_to_email" {
  account_id  = var.cloudflare_account_id
  name        = "Layer 7 DDOS alerts"
  description = "Notification policy to email Layer 7 DDOS summary"
  enabled     = true
  alert_type  = "dos_attack_l7"

  email_integration {
    id = var.su_email_for_notifications
  }
}
