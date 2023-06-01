variable "cloudflare_api_token" {}

terraform {
  cloud {
    organization = "linearstar"
    workspaces {
      name = "mfakane_me"
    }
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
