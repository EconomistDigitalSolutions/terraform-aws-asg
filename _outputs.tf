output "domain-load-balancer" {
  description = "The public domain of the load-balancer"
  value       = "${aws_lb.alb.dns_name}"
}