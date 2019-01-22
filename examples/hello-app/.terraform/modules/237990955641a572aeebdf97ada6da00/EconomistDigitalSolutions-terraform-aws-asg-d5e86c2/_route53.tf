data "aws_route53_zone" "primary" {
  count = "${var.domain-name != "" ? 1 : 0}"

  name = "${var.domain-name}"
}

resource "aws_route53_record" "www" {
  count = "${var.domain-name != "" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.domain-name}"
  type    = "A"

  alias = {
    name                   = "${aws_lb.alb.dns_name}"
    zone_id                = "${aws_lb.alb.zone_id}"
    evaluate_target_health = true
  }
}
