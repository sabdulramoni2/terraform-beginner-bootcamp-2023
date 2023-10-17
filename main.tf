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
  cloud {
    organization = "sabdulramoni2"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "terrahome_aws" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  north_public_path = var.north.public_path
  public_path = var.public_path
  content_version = var.north.content_version
}

resource "terratowns_home" "home" {
  name = "North London derby!!!!!!"
  description =<<DESCRIPTION
The North London derby is the meeting of the association football clubs Arsenal and Tottenham Hotspur,
both of which are based in North London, England. Fans of both clubs consider the other to be their main
rivals, and the derby is considered by many to be one of the fiercest derbies in the world.
DESCRIPTION
  domain_name = module.terrahome_aws.domain_name
  #domain_name = "1133333.cloudfront.net"
  town = "missingo"
  content_version = 1
}


#module "terrahouse_aws2" {
#  source = "./modules/terrahome_aws"
#  user_uuid = var.teacherseat_user_uuid
#  public_path = var.north2.public_path
#  content_version = var.nrth2.content_version
#}

#resource "terratowns_home" "home2" {
#  name = "North London derby!!!!!!"
#  description =<<DESCRIPTION
#The North London derby is the meeting of the association football clubs Arsenal and Tottenham Hotspur,
#both of which are based in North London, England. Fans of both clubs consider the other to be their main
#rivals, and the derby is considered by many to be one of the fiercest derbies in the world.
#DESCRIPTION
#  domain_name = module.terrahouse_aws2.domain_name
#  #domain_name = "1133333.cloudfront.net"
#  town = "missingo"
#  content_version = 1
#}