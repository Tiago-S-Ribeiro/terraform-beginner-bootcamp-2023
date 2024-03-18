# https://developer.hashicorp.com/terraform/tutorials/configuration-language/outputs
# https://spacelift.io/blog/terraform-output
output "bucket_name" {
    description = "Bucket Name for static website hosting"
    value = module.terrahouse_aws.bucket_name
}

output "website_endpoint" {
    description = "S3 static website hosting endpoint"
    value = module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
    description = "The cloudfront distribution domain name"
    value = module.terrahouse_aws.cloudfront_url
}