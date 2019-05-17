output "domain-load-balancer" {
  description = "The public domain of the load-balancer"
  value       = "${aws_lb.alb.dns_name}"
}
<<<<<<< HEAD

output "domain-cloudfront-distribution" {
  description = "The public domain of the cloudfront distribution"
  value       = "${var.use_cloudfront != "false" ? aws_cloudfront_distribution.cdn.domain_name : ""}"
<<<<<<< HEAD
=======

output "domain-cloudfront-distribution" {
  description = "The public domain of the cloudfront distribution"
<<<<<<< HEAD
  value       = "${aws_cloudfront_distribution.cdn.domain_name}"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
  value       = ["${aws_cloudfront_distribution.cdn.domain_name}"]
>>>>>>> 7578a5e... fix count on output (#15)
=======
>>>>>>> 913e701... push fix for conditional output (#19)
}
