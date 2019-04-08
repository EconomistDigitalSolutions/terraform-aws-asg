// You can call the module 'asg' whatever you want
# // This block uses the module from two directories above
module "asg-local" {
  source = "../../"

  aws-profile      = "ds-web-products-staging"
  aws-region       = "eu-west-1"
  user-data-script = "./user-data.sh"
  asg-min-size     = "2"
  asg-max-size     = "4"
  asg-def-size     = "2"
  alb-name         = "hct"

  instance-type        = "t2.medium"
  instance-tag-name    = "hct-instance"
  placement-group-name = "hct-group"
  target-group-name    = "hct-tg"
  launch-config-name   = "hct-lc"
  iam-role-name        = "engage-ECR-read"
  environment          = "dev"
  ssh-allowed-ips      = ["62.255.97.196/32", "62.255.97.197/32"]

  owner                 = "rafael"
  project               = "WE-337"
  product               = "amp"
  emergency-contact     = "rafaelmarques@economist.com"
}
