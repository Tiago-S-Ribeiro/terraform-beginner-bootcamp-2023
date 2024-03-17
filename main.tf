terraform {
#  cloud {
#    organization = "mephisto"
#
#    workspaces {
#      name = "terratowns-house-1"
#    }
#  }
#  required_providers {
#    aws = {
#      source = "hashicorp/aws"
#      version = "5.40.0"
#    }
#  }
}

# https://developer.hashicorp.com/terraform/language/modules/syntax
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
}