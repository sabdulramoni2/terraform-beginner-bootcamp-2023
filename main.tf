terraform {
  cloud {
    organization = "sabdulramoni2"

    workspaces {
      name = "terraform-cloud"
    }
  }

}
module "terrahouse_aws"{
  source = "./modules/terrahouse_aws"
  user_uuid  = var.user_uuid
  bucket_name = var.bucket_name
  error_html_filepath = var./public/error_html_filepath
  index_html_filepath = var.index_html_filepath
}
  
