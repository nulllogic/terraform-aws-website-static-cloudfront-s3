provider "aws" {
  alias                       = "main"
  region                      = "eu-west-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true
  s3_use_path_style           = true
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = false
  skip_metadata_api_check = true
  s3_use_path_style       = true
}
