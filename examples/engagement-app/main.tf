// You can call the module 'asg' whatever you want
# // This block uses the module from two directories above
module "asg-local" {
  source  = "EconomistDigitalSolutions/asg/aws"
  version = "1.0.18"

  aws-profile          = "ds-web-products-staging"
  aws-region           = "eu-west-2"
  user-data-script     = "./user-data.sh"
  asg-min-size         = "1"
  asg-max-size         = "2"
  asg-def-size         = "2"
  alb-name             = "hct"
  instance-type        = "t2.medium"
  instance-tag-name    = "hct-instance"
  placement-group-name = "hct-group"
  target-group-name    = "hct-tg"
  launch-config-name   = "hct-lc"
  iam-role-name        = "engage-ECR-read"
  environment          = "dev"
  ssh-allowed-ips      = ["62.255.97.196/32", "62.255.97.197/32"]
  owner                = "rafael"
  project              = "WE-337"
  product              = "amp"
  emergency-contact    = "rafaelmarques@economist.com"
  ssl_certificate_arn  = "arn:aws:acm:eu-west-2:065882805973:certificate/ce19aba3-d506-48cf-a2de-c097b92b7303"
}
