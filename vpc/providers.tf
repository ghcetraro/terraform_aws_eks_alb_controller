#
terraform {
  required_version = "= 1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.20.0"
      configuration_aliases = [
        aws,
        aws.devops_shared_us_east_1,
        aws.devops_shared_eu_west_2,
      ]
    }
  }
}

provider "aws" {
  region  = var.region
  profile = local.aws_profile
}

provider "aws" {
  alias   = "devops_shared_us_east_1"
  region  = "us-east-1"
  profile = "devops-shared-services"
}

provider "aws" {
  alias   = "devops_shared_eu_west_2"
  region  = "eu-west-2"
  profile = "devops-shared-services"
}