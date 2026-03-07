variable "enable" {
  description = "Basic settings for the project"

  type = object ({
      s3 = object({
        index_html = bool
      })
  })

  default = {
    s3 = {
      index_html = true
    }
  }
}

variable "s3" {
  description = "S3 bucket varitable to store the settings of S3 resource"

  type = object({
    bucket = string
  })

  default = {
    bucket = null
  }
}

variable "route53" {
  description = "Route53 variable to store the settings of Route53 resource"

  type = object({
    domain = string,
    txt_record_multiple = list(string)
  })

  default = {
    domain = null,
    txt_record_multiple = null
  }
}

variable "cloudfront" {

  type = object({
    root = object({
      default_object = string,
      price_class    = string,
    }),
    cache_behavior = object({
      default_ttl = number,
      max_ttl     = number,
      min_ttl     = number,
    })
  })

  default = {
    root = {
      default_object = "index.html"
      price_class    = "PriceClass_200"
    },
    cache_behavior = {
      min_ttl     = 31536000
      max_ttl     = 31536000
      default_ttl = 31536000
    }
  }
}

variable "tags" {
  description = "Special variable to add tags to all resources"
  type        = map(string)
  default     = {}
}

variable "custom_error_responses" {
  description = "Custom error response configurations"
  type = list(object({
    error_code            = number
    response_page_path    = string
    response_code         = number
    error_caching_min_ttl = number
  }))
  default = [
    {
      error_code            = 403
      response_page_path    = "/404.html"
      response_code         = 404
      error_caching_min_ttl = 10
    },
    {
      error_code            = 404
      response_page_path    = "/404.html"
      response_code         = 404
      error_caching_min_ttl = 10
    }
  ]
}