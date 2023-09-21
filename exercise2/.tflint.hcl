config {
    module = true
    force = false
}

plugin "aws" {
    enabled = true
    deep_check = true
    version = "0.27.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_module_pinned_source" {
    enabled = false
}