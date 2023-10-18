output "bucket" {
    description = "Bucket name for our static website hosting"
    value = module.terrahome_aws.bucket_name
}

output "S3_website_endpoint" {
    description = "S3 Static Website hosting endpoint"
    value = module.terrahome_aws.website_endpoint
}


output "cloudfront_url" {
    description = "The Cloufront Distribution Domain Name"
    value = module.terrahome_aws.domain_name
  
}