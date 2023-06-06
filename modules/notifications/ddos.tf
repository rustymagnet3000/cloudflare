resource "cloudflare_notification_policy" "ddos_notifications_to_email" {
  account_id  = var.cloudflare_account_id
  name        = "${element(var.ddos_alerts, count.index)} notification"
  description = "Notification policy for ${element(var.ddos_alerts, count.index)}"
  enabled     = true
  alert_type  = element(var.ddos_alerts, count.index)
  count = length(var.ddos_alerts)

  email_integration {
    id = var.su_email_for_notifications
  }
}


variable "ddos_alerts" {
  type    = list(string)
  default = ["dos_attack_l7", "web_analytics_metrics_update"]
}