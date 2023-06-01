terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

data "cloudflare_zone" "domain" {
  name = var.domain_name
}
