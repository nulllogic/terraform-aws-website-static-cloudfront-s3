#------------------------------------------------------------------------------
# Certificate configuration
#------------------------------------------------------------------------------

resource "aws_acm_certificate" "cert" {
  count    = var.route53.domain != null ? 1 : 0
  provider = aws.acm_provider

  domain_name               = var.route53.domain
  validation_method         = "DNS"
  subject_alternative_names = [var.route53.domain]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  provider = aws.main

  for_each = var.route53.domain != null ? {
    for dvo in aws_acm_certificate.cert[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = !try(var.route53.domain, null) ? data.aws_route53_zone.zone[0].zone_id : null
  ttl             = 60
}

resource "aws_acm_certificate_validation" "cert" {
  count    = var.route53.domain != null ? 1 : 0
  provider = aws.acm_provider

  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
