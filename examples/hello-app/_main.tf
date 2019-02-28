module "asg" {
  source  = "../../"

  # required variables
  aws-profile = "${var.aws-profile}" # provide a profile from ~/.aws/credentials 
  aws-region  = "${var.aws-region}"

  # optional
  instance-ami     = "ami-0dd7e7ed60da8fb83"  # if you change region, you must change the AMI
  user-data-script = "./deploy-hello-node.sh" # deployment script
  asg-min-size     = "2"                      # number of machines
  asg-max-size     = "4"
  asg-def-size     = "2"
}
