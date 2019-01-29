# Load Balancer (application)
# 
resource "aws_lb" "alb" {
  name                       = "${var.alb-name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.sg_alb.id}"]
  subnets                    = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "lb_target" {
  name     = "${var.target-group-name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc.id}"
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action = {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  }
}
