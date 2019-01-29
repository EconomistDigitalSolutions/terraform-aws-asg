module "asg" {
  source = "../../"

  aws-profile                  = "ds-web-products-staging"
  aws-region                   = "eu-west-3"
  instance-ami                 = "ami-0dd7e7ed60da8fb83"
  user-data-script             = "./user-data.sh"
  asg-min-size                 = "2"
  asg-max-size                 = "4"
  asg-def-size                 = "2"
  alb-name                     = "rafa-ian-alb"
  placement-group-name         = "rafa-ian-pg"
  target-group-name            = "rafa-ian-tg"
  asg-name                     = "rafa-ian-asg"
  launch-config-name           = "rafa-ian-lc"
  instance-associate-public-ip = "true"
  iam-role-name                = "engage-ECR-read"
  ssh-allowed-ips              = ["62.255.97.196/32", "62.6.58.84/32"]
}
