resource "aws_placement_group" "test" {
  name     = "${var.placement-group-name}"
  strategy = "cluster"
}

resource "aws_launch_configuration" "launch_config" {
  name                        = "${var.launch-config-name}"
  image_id                    = "${var.instance-ami}"
  #image_id                    = "${data.aws_ami.linux.image_id}"
  instance_type               = "${var.instance-type}"
  iam_instance_profile        = "${var.iam-role-name != "" ? var.iam-role-name : ""}"
  key_name                    = "${var.instance-key-name != "" ? var.instance-key-name : ""}"
  user_data                   = "${var.user-data-script != "" ? file("${var.user-data-script}") : ""}"
  associate_public_ip_address = "${var.instance-associate-public-ip}"                                  # keep this?
  security_groups = ["${aws_security_group.sg.id}"]
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.asg-name}"
  min_size                  = "${var.asg-min-size}"
  desired_capacity          = "${var.asg-def-size}"
  max_size                  = "${var.asg-max-size}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  #placement_group           = "${aws_placement_group.test.id}"
  launch_configuration      = "${aws_launch_configuration.launch_config.name}"
  vpc_zone_identifier       = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
  target_group_arns         = ["${aws_lb_target_group.lb_target.arn}"]
}

# resource "aws_instance" "instance" {
#   ami           = "${var.instance-ami}"
#   instance_type = "${var.instance-type}"

#   iam_instance_profile        = "${var.iam-role-name != "" ? var.iam-role-name : ""}"
#   key_name                    = "${var.instance-key-name != "" ? var.instance-key-name : ""}"
#   associate_public_ip_address = "${var.instance-associate-public-ip}"

#   # user_data                   = "${file("${var.user-data-script}")}"
#   user_data              = "${var.user-data-script != "" ? file("${var.user-data-script}") : ""}"
#   vpc_security_group_ids = ["${aws_security_group.sg.id}"]
#   subnet_id              = "${aws_subnet.subnet-1.id}"

#   tags = {
#     Name = "${var.instance-tag-name}"
#   }
# }

