terraform {
  cloud {
    organization = "hansjmelby"

    workspaces {
      name = "platform"
    }
  }

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.43"
    }
  }

  required_version = ">= 1.5.0"
}
