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
  name     = "${var.target-group-name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc.id}"
<<<<<<< HEAD
  # slow_start = 120
=======
>>>>>>> ff64900f54abc8870484f31ea072b78a442c3f11

  health_check = {
    interval = 6
    timeout  = 5
    path     = "${var.health-check-path}"
    port     = "${var.health-check-port}"
<<<<<<< HEAD
    matcher  = "200"
=======
    matcher  = "200-299"
>>>>>>> ff64900f54abc8870484f31ea072b78a442c3f11
  }

  tags = "${local.common_tags}"
}

resource "aws_lb_listener" "lb_listener" {
  # depends_on = ["aws_lb_target_group.lb_target"]

  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action = {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  }
}
