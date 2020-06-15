# data "aws_route53_zone" "primary" {
#   count = "${var.domain-name != "" ? 1 : 0}"

#   name = "${var.domain-name}"
# }

# data "aws_acm_certificate" "example" {
#   count = "${var.use_cloudfront != "false" ? 1 : 0}"

#   provider = "aws.useast1"                                // SSL certificate must be in US-east-1 to use with Cloudfront
#   domain   = "${var.domain-name}"
# }

data "aws_route53_zone" "primary" {
  count = "${var.root-domain != "" ? 1 : 0}"

  name = "${var.root-domain}"
}

data "aws_acm_certificate" "example" {
  count = "${var.use_cloudfront != "false" ? 1 : 0}"

  provider = "aws.useast1"                                // SSL certificate must be in US-east-1 to use with Cloudfront
  domain   = "${var.root-domain}"
}

// Route53 for Cloudfront
resource "aws_route53_record" "www" {
  count = "${var.domain-name != "" ? 1 : 0}"

  depends_on = ["aws_lb.alb", "aws_cloudfront_distribution.cdn"]

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.domain-name}"
  type    = "A"

  alias = {
    // we use concat because 'count' makes the response of the resource a list.
    // link to similar issue: https://stackoverflow.com/questions/45654774/terraform-conditional-resource
    name                   = "${var.use_cloudfront == "true" ? element(concat(aws_cloudfront_distribution.cdn.*.domain_name, list("")), 0) : aws_lb.alb.dns_name}"
    zone_id                = "${var.use_cloudfront == "true" ? element(concat(aws_cloudfront_distribution.cdn.*.hosted_zone_id, list("")), 0) : aws_lb.alb.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "internal-dns" {
  count = "${var.use_cloudfront != "false" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.internal-domain-name}"
  type    = "A"

  depends_on = ["aws_lb.alb"]

  weighted_routing_policy = {
    weight = "${var.internal-domain-weight}"
  }

  set_identifier = "old_env"

  alias = {
    name = "${aws_lb.alb.dns_name}"
    zone_id = "${aws_lb.alb.zone_id}"
    evaluate_target_health = false
  }
}

# configure sub-domain
# resource "aws_route53_record" "sub" {
#   count = "${var.sub-domain-name != "" ? 1 : 0}"

#   zone_id = "${data.aws_route53_zone.primary.zone_id}"
#   name    = "${var.sub-domain-name}"
#   type    = "A"

#   alias = {
#     name                   = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.domain_name : aws_lb.alb.dns_name}"
#     zone_id                = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.hosted_zone_id : aws_lb.alb.zone_id}"
#     evaluate_target_health = true
#   }
# }
