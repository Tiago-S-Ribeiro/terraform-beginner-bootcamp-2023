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

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}