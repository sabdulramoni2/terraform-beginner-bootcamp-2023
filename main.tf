terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "North London derby!!!!!!"
  description =<<DESCRIPTION
The North London derby is the meeting of the association football clubs Arsenal and Tottenham Hotspur,
both of which are based in North London, England. Fans of both clubs consider the other to be their main
rivals, and the derby is considered by many to be one of the fiercest derbies in the world.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "1133333.cloudfront.net"
  town = "missingo"
  content_version = 1
}