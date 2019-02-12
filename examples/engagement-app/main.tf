// You can call the module 'asg' whatever you want
# // This block uses the module from two directories above
module "asg-local" {
  source = "../../"

  aws-profile          = "ds-web-products-prod"
  aws-region           = "us-east-1"
  user-data-script     = "./user-data.sh"
  asg-min-size         = "1"
  asg-max-size         = "4"
  asg-def-size         = "2"
  alb-name             = "rafa-lizzie-alb"
  //instance-key-name    = "engage-paris-key"
  instance-type        = "t2.medium"
  instance-tag-name    = "AMP-app-ec2-instance" 
  placement-group-name = "rafa-lizzie-pg"
  target-group-name    = "rafa-lizzie-tg"
  asg-name             = "rafa-lizzie-asg"
  launch-config-name   = "rafa-lizzie-lc"
  iam-role-name        = "engage-ECR-read"
  ssh-allowed-ips      = ["62.255.97.196/32", "62.255.97.197/32"]
}

// This is the exact same block,
// but uses the module from the terraform registry

# module "asg-registry" {
#   source  = "EconomistDigitalSolutions/asg/aws"
#   version = "1.0.4"

#   aws-profile          = "ds-web-products-staging"
#   aws-region           = "eu-west-3"
#   instance-ami         = "ami-0dd7e7ed60da8fb83"
#   user-data-script     = "./user-data.sh"
#   asg-min-size         = "2"
#   asg-max-size         = "4"
#   asg-def-size         = "2"
#   alb-name             = "rafa-lizzie-alb"
#   instance-key-name    = "engage-paris-key"
#   instance-type        = "t2.medium"
#   instance-tag-name    = "AMP-app-ec2-instance" 
#   placement-group-name = "rafa-lizzie-pg"
#   target-group-name    = "rafa-lizzie-tg"
#   asg-name             = "rafa-lizzie-asg"
#   launch-config-name   = "rafa-lizzie-lc"
#   iam-role-name        = "engage-ECR-read"
#   ssh-allowed-ips      = ["62.255.97.196/32", "62.255.97.197/32"]
# }