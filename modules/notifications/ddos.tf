resource "cloudflare_notification_policy" "notifications_to_email" {
  account_id  = var.cloudflare_account_id
  name        = "${element(var.my_alerts, count.index)} notification"
  description = "Notification policy for ${element(var.my_alerts, count.index)}"
  enabled     = true
  alert_type  = element(var.my_alerts, count.index)
  count       = length(var.my_alerts)

  dynamic "email_integration" {
    iterator = email_address
    for_each = var.emails_for_notifications
    content {
      id = email_address.value
    }
  }
}

variable "my_alerts" {
  type = list(string)
  default = [
    "dos_attack_l7",
    "fbm_dosd_attack",
  ]
}
