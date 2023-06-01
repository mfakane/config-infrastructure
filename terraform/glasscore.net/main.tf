variable "cloudflare_api_token" {}
variable "betteruptime_api_token" {}

terraform {
  cloud {
    organization = "linearstar"
    workspaces {
      name = "glasscore_net"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3"
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
