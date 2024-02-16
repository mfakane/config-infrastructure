variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

terraform {
  backend "s3" {
    bucket = "tfstate-linearstar"
    key    = "mfakane.me/terraform.tfstate"
    region = "us-east-1"

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

data "cloudflare_zone" "domain" {
  name = "mfakane.me"
}
