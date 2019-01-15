module "asg" {
  source  = "EconomistDigitalSolutions/asg/aws"
  version = "1.0.0"

  # required variables
  aws-profile       = "${var.aws-profile}"          # provide a profile from ~/.aws/credentials 
  aws-region        = "${var.aws-region}"                 

  # optinal
  instance-ami      = "ami-0dd7e7ed60da8fb83"       # if you change region, you must change the AMI
  user-data-script  = "./deploy-hello-node.sh"      # deployment script
  asg-min-size      = "1"                           # number of machines
  asg-max-size      = "1"
  asg-def-size      = "1"
}
