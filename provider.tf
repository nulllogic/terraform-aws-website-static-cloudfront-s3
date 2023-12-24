terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.8.0",
      configuration_aliases = [aws.main, aws.acm_provider]
    }
  }
}

provider "aws" {
  alias                       = "main"
  region                      = "eu-west-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true
  s3_use_path_style           = true
  profile                     = "AdministratorAccess-894917523912"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
  #  skip_credentials_validation = true
  #  skip_requesting_account_id  = false
  skip_metadata_api_check = true
  s3_use_path_style       = true
  profile                 = "AdministratorAccess-894917523912"
}
