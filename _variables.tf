variable "aws-region" {
  description = "The AWS region"
  type        = "string"
}

variable "aws-profile" {
  description = "The name of the AWS shared credentials account."
  type        = "string"
}

variable "instance-ami" {
  description = "The AMI (Amazon Machine Image) that identifies the instance"
  type        = "string"
  default     = "ami-01419b804382064e4"
}

variable "instance-type" {
  description = "The instance type to be used"
  type        = "string"
  default     = "t2.micro"
}

variable "instance-key-name" {
  description = "The name of the SSH key to associate to the instance. Note that the key must exist already."
  type        = "string"
  default     = ""
}

variable "iam-role-name" {
  description = "The IAM role to assign to the instance"
  type        = "string"
  default     = ""
}

variable "instance-associate-public-ip" {
  description = "Defines if the EC2 instance has a public IP address."
  type        = "string"
  default     = "true"
}

variable "user-data-script" {
  description = "The filepath to the user-data script, that is executed upon spinning up the instance"
  type        = "string"
  default     = ""
}

variable "instance-tag-name" {
  description = "instance-tag-name"
  type        = "string"
  default     = "EC2-instance-created-with-terraform"
}

variable "vpc-cidr-block" {
  description = "The CIDR block to associate to the VPC"
  type        = "string"
  default     = "10.0.0.0/16"
}

variable "subnet-1-cidr-block" {
  description = "The CIDR block to associate to the subnet"
  type        = "string"
  default     = "10.0.0.0/24"
}

variable "subnet-2-cidr-block" {
  description = "The CIDR block to associate to the subnet"
  type        = "string"
  default     = "10.0.1.0/24"
}

variable "vpc-tag-name" {
  description = "The Name to apply to the VPC"
  type        = "string"
  default     = "VPC-created-with-terraform"
}

variable "ig-tag-name" {
  description = "The name to apply to the Internet gateway tag"
  type        = "string"
  default     = "aws-ig-created-with-terraform"
}

variable "subnet-tag-name" {
  description = "The Name to apply to the VPN"
  type        = "string"
  default     = "VPN-created-with-terraform"
}

variable "sg-tag-name" {
  description = "The Name to apply to the security group"
  type        = "string"
  default     = "SG-created-with-terraform"
}

variable "environment" {
  description = "The environment (production/staging)"
  type        = "string"
  default     = "staging"
}

variable "alb-name" {
  description = "The application Load Balancer name"
  type        = "string"
  default     = "app-load-balancer-w-terraform"
}

variable "sg-alb-tag-name" {
  description = "The name of the SG associated with the ALB"
  type        = "string"
  default     = "SG-to-theapp-load-balancer-with-terraform"
}

variable "placement-group-name" {
  description = "The name of the placement group"
  type        = "string"
  default     = "placement-group-created-w-terraform"
}

variable "target-group-name" {
  description = "The name of the placement group"
  type        = "string"
  default     = "lb-tg"
}

variable "launch-config-name" {
  description = "The name of the launch configuration"
  type        = "string"
  default     = "launch-configuration-created-with-terraform"
}

variable "asg-name" {
  description = "The name of the Auto Scaling Group"
  type        = "string"
  default     = "ASG-created-with-terraform"
}

variable "asg-min-size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = "string"
  default     = 2
}

variable "asg-max-size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = "string"
  default     = 4
}

variable "asg-def-size" {
  description = "The default/recommended size of the Auto Scaling Group"
  type        = "string"
  default     = 3
}

variable "domain-name" {
  description = "The apps public domain name"
  type        = "string"
  default     = ""
}

variable "sub-domain-name" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = ""
}

variable "internal-domain-name" {
  description = "Internal DNS name which refers to the ALB"
  type        = "string"
}

variable "internal-domain-weight" {
  description = "Internal DNS weight which refers to the ALB"
  type        = "string"
  default     = 100
}

variable "ssh-allowed-ips" {
  description = "The list of IPs that are allowed to SSH into the instances"
  type        = "list"
  default     = []
}

variable "health-check-path" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = "/"
}

variable "health-check-port" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = "80"
}

variable "health_check_interval" {
  description = "The interval between health checks"
  type        = "string"
  default     = 5
}

variable "health_check_threshold" {
  description = "The number of consecutive health checks to be considered (un)healthy."
  type        = "string"
  default     = 3
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health."
  type        = "string"
  default     = 3
}

variable "product" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = ""
}

variable "project" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = ""
}

variable "emergency-contact" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = ""
}

variable "owner" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = ""
}

variable "git-hash" {
  description = "The apps public sub domain name"
  type        = "string"
  default     = ""
}

variable "ssl_certificate_arn" {
  description = "The ARN of the SSL certificate for the load-balancer"
  type        = "string"
  default     = ""
}

variable "use_https_only" {
  description = "If true, forces all http traffic to https"
  type        = "string"
  default     = "false"
}

variable "use_cloudfront" {
  description = "If true, will create a CFD distribution"
  type        = "string"
  default     = "false"
}

variable "s3_bucket_for_cloudfront_logs" {
  description = "The name of the S3 bucket that holds the cloudfront logs"
  type        = "string"
  default     = ""
}

variable "cfd_default_regular_ttl" {
  description = "The (regular) TTL of the default cache behaviour"
  type        = "string"
  default     = 3600
}

variable "cfd_default_max_ttl" {
  description = "The maximum TTL of the default cache behaviour"
  type        = "string"
  default     = 86400
}

variable "hostnames_staging" {
  description = "The hostnames for the staging environment"
  type        = "list"
  default     = []
}

variable "hostnames_prod" {
  description = "The hostnames for the production environment"
  type        = "list"
  default     = []
}

variable "root-domain" {
  description = "The hostnames for the production environment"
  type        = "string"
  default     = ""
}

