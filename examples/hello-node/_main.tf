module "terraform-aws-ec2" {
  source = "../../module"

  aws-region        = "${var.aws-region}"
  aws-profile       = "${var.aws-profile}"
  user-data-script  = "${var.user-data-script}"
  instance-key-name = "${var.instance-key-name}"
  instance-ami      = "${var.instance-ami}"
  instance-type     = "${var.instance-type}"
  asg-min-size      = "${var.asg-min-size}"
  asg-max-size      = "${var.asg-max-size}"
  asg-def-size      = "${var.asg-def-size}"
}
