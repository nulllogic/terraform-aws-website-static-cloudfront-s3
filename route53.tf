#------------------------------------------------------------------------------
# Route53 configuration
#------------------------------------------------------------------------------

data "aws_route53_zone" "zone" {
  count        = !try(var.route53.domain, null) ? 1 : 0
  provider     = aws.main
  name         = var.route53.domain
  private_zone = false
}

resource "aws_route53_record" "website" {
  count = !try(var.route53.domain, null) ? 1 : 0

  zone_id = data.aws_route53_zone.zone[0].id
  name    = var.route53.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = true
  }
}
