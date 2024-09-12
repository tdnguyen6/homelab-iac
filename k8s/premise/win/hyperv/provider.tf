terraform {
  required_providers {
    hyperv = {
      source  = "taliesins/hyperv"
      version = "~> 1.0"
    }
  }
}

provider "hyperv" {
  port     = 5985
  https    = false
  insecure = true
  use_ntlm = false
}
