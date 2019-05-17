data "aws_route53_zone" "primary" {
  count = "${var.domain-name != "" ? 1 : 0}"

  name = "${var.domain-name}"
}

data "aws_acm_certificate" "example" {
<<<<<<< HEAD
<<<<<<< HEAD
  count    = "${var.use_cloudfront != "false" ? 1 : 0}"
=======
  count    = "${var.use_cloudfront ? 1 : 0}"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
  count    = "${var.use_cloudfront != "false" ? 1 : 0}"
>>>>>>> 1f967ab... fixed boolean type (#14)

  provider = "aws.useast1"
  domain   = "${var.domain-name}"
}

resource "aws_route53_record" "www" {
  count = "${var.domain-name != "" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.domain-name}"
  type    = "A"

  alias = {
<<<<<<< HEAD
<<<<<<< HEAD
    name                   = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.domain_name : aws_lb.alb.dns_name}"
    zone_id                = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.hosted_zone_id : aws_lb.alb.zone_id}"
=======
    name                   = "${var.use_cloudfront ? aws_cloudfront_distribution.cdn.domain_name : aws_lb.alb.dns_name}"
    zone_id                = "${var.use_cloudfront ? aws_cloudfront_distribution.cdn.hosted_zone_id : aws_lb.alb.zone_id}"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
    name                   = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.domain_name : aws_lb.alb.dns_name}"
    zone_id                = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.hosted_zone_id : aws_lb.alb.zone_id}"
>>>>>>> 1f967ab... fixed boolean type (#14)
    evaluate_target_health = true
  }
}

# configure sub-domain
resource "aws_route53_record" "sub" {
  count = "${var.sub-domain-name != "" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.sub-domain-name}"
  type    = "A"

  alias = {
<<<<<<< HEAD
<<<<<<< HEAD
    name                   = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.domain_name : aws_lb.alb.dns_name}"
    zone_id                = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.hosted_zone_id : aws_lb.alb.zone_id}"
=======
    name                   = "${var.use_cloudfront ? aws_cloudfront_distribution.cdn.domain_name : aws_lb.alb.dns_name}"
    zone_id                = "${var.use_cloudfront ? aws_cloudfront_distribution.cdn.hosted_zone_id : aws_lb.alb.zone_id}"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
    name                   = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.domain_name : aws_lb.alb.dns_name}"
    zone_id                = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.hosted_zone_id : aws_lb.alb.zone_id}"
>>>>>>> 1f967ab... fixed boolean type (#14)
    evaluate_target_health = true
  }
}
