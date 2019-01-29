module "asg" {
  source  = "EconomistDigitalSolutions/asg/aws"
  version = "1.0.0"

  # required variables
  aws-profile = "${var.aws-profile}" # provide a profile from ~/.aws/credentials 
  aws-region  = "${var.aws-region}"

  instance-ami                 = "ami-0dd7e7ed60da8fb83"  # if you change region, you must change the AMI
  user-data-script             = "./deploy-hello-node.sh" # deployment script
  asg-min-size                 = "2"                      # number of machines
  asg-max-size                 = "5"
  asg-def-size                 = "3"
  alb-name                     = "private-test"
  placement-group-name         = "private-test"
  target-group-name            = "private-test"
  asg-name                     = "private-test"
  launch-config-name           = "private-test"
  instance-associate-public-ip = "false"
}
