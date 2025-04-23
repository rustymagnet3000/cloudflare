locals {

  challenged_markets_str = join(" ", formatlist("\"country-code:%s\"", var.challenged_markets_list))

  southern_european_markets = [
    "\"IT\"",
    "\"FR\"",
    "\"ES\"",
    "\"GR\"",
    "\"PT\"",
  ]
  zone_settings = {
    "security_level" = "medium",
    "ssl"            = "full",
  }
}

