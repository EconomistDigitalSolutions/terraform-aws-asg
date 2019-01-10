# Load Balancer
resource "aws_lb" "alb" {
  name                       = "${var.alb-name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.sg_alb.id}"]
  subnets                    = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
  enable_deletion_protection = false

  tags = {
    Environment = "${var.environment}"
  }
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

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
  alb_target_group_arn   = "${aws_lb_target_group.lb_target.arn}"
}
 
# resource "aws_lb_target_group_attachment" "lb_target_attach" {
#   target_group_arn = "${aws_lb_target_group.lb_target.arn}"
#   #target_id        = "${aws_instance.instance.id}"
#   target_id        = "${aws_lb.alb.id}"
#   port             = 80
# }
