plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

config {
  disabled_by_default = false
}

rule "terraform_required_providers" { enabled = false }
rule "terraform_required_version" { enabled = false }