config {
  disabled_by_default = false
  ignore_module       = {}
}

plugin "terraform" {
  enabled = true
}

rule "terraform_required_providers" { enabled = false }
rule "terraform_required_version" { enabled = false }

# Every directory here is a Root Module with its own state file, not a
# reusable child module, so main.tf and outputs.tf are not expected.
rule "terraform_standard_module_structure" { enabled = false }
