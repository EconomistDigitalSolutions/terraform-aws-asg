module "asg" {
  source  = "../../"

  # required variables
<<<<<<< HEAD
  # aws-profile = "${var.aws-profile}"          # provide a profile from ~/.aws/credentials 
  # aws-region  = "${var.aws-region}"
  aws-profile = "ds-web-products-staging"
  aws-region  = "eu-west-1"


  # optinal
=======
  aws-profile = "${var.aws-profile}" # provide a profile from ~/.aws/credentials 
  aws-region  = "${var.aws-region}"

  # optinal
  instance-ami     = "ami-0dd7e7ed60da8fb83"  # if you change region, you must change the AMI
>>>>>>> ff64900f54abc8870484f31ea072b78a442c3f11
  user-data-script = "./deploy-hello-node.sh" # deployment script
  asg-min-size     = "2"                      # number of machines
  asg-max-size     = "4"
  asg-def-size     = "2"
<<<<<<< HEAD
  iam-role-name    = "engage-ECR-read"
  instance-type    = "t2.medium"
=======
>>>>>>> ff64900f54abc8870484f31ea072b78a442c3f11
}
