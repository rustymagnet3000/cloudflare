terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "= 3.20.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}



