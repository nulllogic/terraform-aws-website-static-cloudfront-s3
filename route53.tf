#------------------------------------------------------------------------------
# Route53 configuration
#------------------------------------------------------------------------------

data "aws_route53_zone" "zone" {
  provider     = aws.main
  name         = local.domain
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  provider = aws.main

  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
  ttl             = 60
}

resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.zone.id
  name    = local.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = true
  }

}
