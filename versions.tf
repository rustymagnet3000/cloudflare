terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.24.0"
    }
  }
}

provider "cloudflare" {
  # Configuration options
}