plugin "terraform" {
  enabled = true
}

config {
  force = false
  disabled_by_default = false
  ignore_module = {}
}

rule "terraform_required_providers" { enabled = false }
rule "terraform_required_version" { enabled = false }