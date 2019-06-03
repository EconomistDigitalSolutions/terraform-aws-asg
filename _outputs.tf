output "domain-load-balancer" {
  description = "The public domain of the load-balancer"
  value       = "${aws_lb.alb.dns_name}"
}

output "cloudfront-id" {
  description = "The AWS ID of the cloudfront distribution"
  value       = "${join(" ", aws_cloudfront_distribution.cdn.*.id)}"
}

