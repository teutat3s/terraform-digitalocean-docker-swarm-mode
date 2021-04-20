
terraform {
  required_version = ">= 0.13"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.7"
    }
    external = {
      source = "hashicorp/external"
      version = "~> 2.1"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1"
    }
    template = {
      source = "hashicorp/template"
      version = "~> 2.2"
    }
  }
}
