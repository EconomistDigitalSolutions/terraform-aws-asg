variable "aws-region" {
  description = "The AWS region"
  type        = "string"
}

variable "aws-profile" {
  description = "The name of the AWS shared credentials account."
  type        = "string"
}

variable "instance-type" {
  description = "The instance type to be used"
  type        = "string"
  default     = "t2.micro"
}


variable "instance-key-name" {
  description = "The name of the SSH key to associate to the instance. Note that the key must exist already."
  type        = "string"
}

variable "user-data-script" {
  description = "The filepath to the user-data script, that is executed upon spinning up the instance"
  type        = "string"
}

variable "instance-ami" {
  description = "The AMI (Amazon Machine Image) that identifies the instance"
  type        = "string"
}


variable "asg-min-size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = "string"
}

variable "asg-max-size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = "string"
}

variable "asg-def-size" {
  description = "The default/recommended size of the Auto Scaling Group"
  type        = "string"
}

