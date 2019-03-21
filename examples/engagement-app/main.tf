// You can call the module 'asg' whatever you want
# // This block uses the module from two directories above
module "asg-local" {
  source = "../../"

  aws-profile      = "ds-web-products-staging"
  aws-region       = "eu-west-2"
  user-data-script = "./user-data.sh"
  asg-min-size     = "2"
  asg-max-size     = "4"
  asg-def-size     = "2"
  alb-name         = "rafa-lizzie-alb"

  //instance-key-name    = "engage-paris-key"
  instance-type        = "t2.medium"
  instance-tag-name    = "rl-instance"
  placement-group-name = "rl-group"
  target-group-name    = "rl-tg"
  launch-config-name   = "AMP-engagement-app-lc"
  iam-role-name        = "engage-ECR-read"
  environment          = "staging"
  ssh-allowed-ips      = ["62.255.97.196/32", "62.255.97.197/32"]

  owner                 = "Engagement Team"
  project               = "Engagement"
  product               = "Engagement AMP App"
  emergency-contact     = "rafaelmarques@economist.com"
  ssl_certificate_arn   = "arn:aws:acm:eu-west-2:199344973012:certificate/07e1eb29-91dc-4e5b-b1eb-e9dfd0201d0a"
}
