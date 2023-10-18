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
  public_path = var.north.public_path
  content_version = var.north.content_version
} 

resource "terratowns_home" "home" {
  name = "JOLLOF RICE!!!!!!"
  description =<<DESCRIPTION
Jollof rice, is a rice dish from West Africa. The dish is typically made with long-grain rice, tomatoes, chilies, onions, spices,
and sometimes other vegetables and/or meat in a single pot, although its ingredients and preparation methods vary across different regions.
The dish's origins trace to the Senegambian region.Regional variations are a source of competition between the countries of West Africa, 
and in particular Nigeria and Ghana, over whose version is the best; in the 2010s this developed into a friendly rivalry
known as the "Jollof Wars".
DESCRIPTION
  domain_name = module.terrahome_aws.domain_name
  #domain_name = "1133333.cloudfront.net"
  town = "cooker-cove"
  content_version = var.north.content_version
}


module "terrahouse_aws2" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.north2.public_path
  content_version = var.north2.content_version
}

resource "terratowns_home" "home2" {
  name = "JAGUN JAGUN!!!!!!"
  description =<<DESCRIPTION
A young man determined to become a mighty warrior joins an elite army, encountering the wrath of a maniacal warlord and the love of a woman.
DESCRIPTION
  domain_name = module.terrahouse_aws2.domain_name
  #domain_name = "1133333.cloudfront.net"
  town = "video-valley"
  content_version = var.north2.content_version
}