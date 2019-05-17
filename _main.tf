provider "aws" {
  region  = "${var.aws-region}"
  profile = "${var.aws-profile}"
}

provider "aws" {
  region  = "us-east-1"
  profile = "${var.aws-profile}"
  alias   = "useast1"
}
