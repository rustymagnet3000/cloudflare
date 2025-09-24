terraform {
  # https://developer.hashicorp.com/terraform/language/providers/requirements#best-practices-for-provider-versions
  # https://developer.hashicorp.com/terraform/language/expressions/version-constraints
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>5.10"
    }
  }

  backend "s3" {
    bucket = "rm-terraform"
    key    = "terraform.tfstate"
    region = "auto"

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    use_path_style              = true

    /*
      ENVIRONMENT VARIABLES
      ---------------------
      AWS_ACCESS_KEY_ID     - R2 token
      AWS_SECRET_ACCESS_KEY - R2 secret
      AWS_ENDPOINT_URL_S3   - R2 location: https://ACCOUNT_ID.r2.cloudflarestorage.com
    */
  }
}

provider "cloudflare" {
  # Configuration options
}

