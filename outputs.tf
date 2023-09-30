output "bucket" {
    description = "Bucket name for our static website"
    value = module.terrahouse_aws.bucket_name
  
}