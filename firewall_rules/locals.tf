locals {
  challenged_markets_str = join(" ", formatlist("\"%s\"", var.challenged_markets_list))

  paths_to_protection = [
    "\"/generate\"",
    "\"/verify\"",
  ]
}
