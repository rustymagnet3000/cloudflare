config {
  disabled_by_default = false
  ignore_module = {}
}

plugin "terraform" {
  enabled = true
}

rule "terraform_required_providers" { enabled = false }
rule "terraform_required_version" { enabled = false }
