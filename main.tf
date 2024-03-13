terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "random" { }
provider "aws" { }

resource "random_string" "bucket_name" {
    length           = 16
    lower            = true
    upper            = false
    special          = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

}

output "random_output_result" {
    value = random_string.bucket_name.result
}
