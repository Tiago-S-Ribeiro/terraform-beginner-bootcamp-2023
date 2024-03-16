terraform {
#  cloud {
#    organization = "mephisto"
#
#    workspaces {
#      name = "terratowns-house-1"
#    }
#  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "random" { }
provider "aws" { }