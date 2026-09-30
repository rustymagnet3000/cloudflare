# part of shifting resources under /Notifications to own state file
removed {
  from = module.notifications.cloudflare_notification_policy.notifications_to_email

  lifecycle {
    destroy = false
  }
}
