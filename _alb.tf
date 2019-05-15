# Load Balancer (application)
# 
resource "aws_lb" "alb" {
  name                       = "${var.alb-name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.sg_alb.id}"]
  subnets                    = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
  enable_deletion_protection = false

  tags = "${local.common_tags}"
}

resource "aws_lb_target_group" "lb_target" {
  name_prefix = "${var.target-group-name}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.vpc.id}"

  health_check = {
    interval            = "${var.health_check_interval}"
    healthy_threshold   = "${var.health_check_threshold}"
    unhealthy_threshold = "${var.health_check_threshold}"
    timeout             = "${var.health_check_threshold}"
    path                = "${var.health-check-path}"
    port                = "${var.health-check-port}"
    matcher             = "200"
  }

  tags = "${local.common_tags}"
}

resource "aws_lb_listener" "lb_listener" {
  count = "${var.use_https_only == "true" ? 0 : 1}"

  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action = {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  }
}

resource "aws_lb_listener" "lb_listener_redirect_http" {
  count = "${var.use_https_only == "true" ? 1 : 0}"

  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action = {
    type = "redirect"

    redirect = {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "lb_listener_https" {
  count = "${var.ssl_certificate_arn != "" ? 1 : 0}"

  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.ssl_certificate_arn}"

  default_action = {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  }
}
