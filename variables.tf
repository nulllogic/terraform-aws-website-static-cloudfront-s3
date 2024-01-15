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
  description = "Route53 varitable to store the settings of Route53 resource"

  type = object({
    domain = string
  })

  default = {
    domain = null
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
