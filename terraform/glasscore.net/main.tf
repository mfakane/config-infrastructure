variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "betteruptime_api_token" {
  type      = string
  sensitive = true
}

terraform {
  backend "s3" {
    bucket = "tfstate-linearstar"
    key    = "glasscore.net/terraform.tfstate"
    region = "us-east-1"

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.11"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "betteruptime" {
  api_token = var.betteruptime_api_token
}

data "cloudflare_zone" "domain" {
  name = "glasscore.net"
}
