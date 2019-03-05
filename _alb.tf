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
    interval = 30
    healthy_threshold = 5
    unhealthy_threshold = 5
    timeout  = 5
    path     = "${var.health-check-path}"
    port     = "${var.health-check-port}"
    matcher  = "200"
  }

  tags = "${local.common_tags}"
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action = {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  }

  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  stage_certificate_arn = "arn:aws:acm:eu-west-2:065882805973:certificate/ce19aba3-d506-48cf-a2de-c097b92b7303"
  prod_certificat_arn = ""

  default_action {
    type             = "forward"
    alb_target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  }
}
