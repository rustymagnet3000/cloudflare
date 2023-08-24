
output "in_markets" {
  value = [for s in var.my_markets : format("%q", s)]
}


