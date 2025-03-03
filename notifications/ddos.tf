# step 1 part of v4-v5 upgrade process
# removed {
#   from = cloudflare_notification_policy.dos_attack_l7_notification

#   lifecycle {
#     destroy = false
#   }
# }

# step 2 part of v4-v5 upgrade proce
import {
  id = "${var.cloudflare_account_id}/c540e8909a0847028d7544c9dbe24181"
  to = cloudflare_notification_policy.dos_attack_l7_notification
}

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
