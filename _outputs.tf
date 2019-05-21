output "domain-load-balancer" {
  description = "The public domain of the load-balancer"
  value       = "${aws_lb.alb.dns_name}"
}

output "domain-cloudfront-distribution" {
  description = "The public domain of the cloudfront distribution"
  value       = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.domain_name : ""}"
}
