variable "config" {
  description = "Special variable to add additional logic for our module"

  type = object({
    enable_custom_domain            = bool
    issue_custom_domain_certificate = bool
  })

  default = {
    enable_custom_domain            = false
    issue_custom_domain_certificate = false
  }
}

variable "s3" {
  description = "S3 bucket varitable to store the settings of S3 resource"

  type = object({
    bucket_name = string
  })

  default = {
    bucket_name = null
  }
}

variable "route53" {
  description = "Route53 varitable to store the settings of Route53 resource"

  type = object({
    domain_name = string
  })

  default = {
    domain_name = null
  }
}

variable "cloudfront" {

  type = object({
    default_root_object      = string,
    default_root_object      = string,
    default_ttl              = number,
    max_ttl                  = number,
    min_ttl                  = number,
    minimum_protocol_version = string,
    price_class              = string,
  })

  default = {
    default_root_object      = "index.html"
    minimum_protocol_version = "TLSv1.2_2021",
    price_class              = "PriceClass_200"
  }
}

variable "tags" {
  description = "Special variable to add tags to all resources"
  type        = map(string)
  default     = {}
}
