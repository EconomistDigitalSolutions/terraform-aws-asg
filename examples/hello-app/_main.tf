module "asg" {
  source  = "../../"

  # required variables
  # aws-profile = "${var.aws-profile}"          # provide a profile from ~/.aws/credentials 
  # aws-region  = "${var.aws-region}"
  aws-profile = "ds-web-products-staging"
  aws-region  = "eu-west-1"


  # optinal
  user-data-script = "./deploy-hello-node.sh" # deployment script
  asg-min-size     = "2"                      # number of machines
  asg-max-size     = "4"
  asg-def-size     = "2"
  iam-role-name    = "engage-ECR-read"
  instance-type    = "t2.medium"
}
