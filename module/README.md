# Terraform-aws-asg

This module provisions the necessary resources to run a (docker) application in an Auto Scaling Group (ASG) of EC2 instances. This module should be production ready.

## Table of contents

- [Terraform-aws-asg](#terraform-aws-asg)
  - [WWH - What, Why, How](#wwh---what-why-how)
  - [Implementation details](#implementation-details)
  - [Illustration](#illustration)
  - [Input/Output](#inputoutput)
  - [Considerations](#considerations)

<hr/>

## WWH - What, Why, How

* **What?** Deploys, manages and destroys the AWS resources necessary to run applications in an Auto Scaling Group of EC2 instances

* **Why?** Auto Scaling Groups enable the infrastructure to be adjusted to the application load. Re-usable module. 

* **How?** This module deploys all stacks of the required infrastructure. To run an application on the infrastructure, it is necessary to provide a deployment script for the containerized application. 

<hr/>

## Implementation details

Below is a simplified and complete list of the AWS resources deployed.


The **simplified** stack:
  * Compute
    * EC2 instances
  * Scale
    * Auto Scaling Group
    * Load Balancer
  * Security
    * Security Groups for instances
    * Security Groups for load balancer
  * Domain (optional)
    * domain name

&nbsp;

The **complete** stack:
  * Compute
    * EC2 instances
  * Scale
    * Auto Scaling Group
    * ASG attachment (to load balancer)
    * EC2 launch configuration
  * Load Balancers
    * Load balancer
    * LB Target Group
    * LB listener
  * Network
    * Virtual Private Cloud
    * Subnets (Public)
    * Internet Gateway
    * Routing
      * route tables
      * route table associations (to subnet)
    * Security Groups  
      * for instances
      * for load balancer
  * Domain (optional)
    * Route53 record

<hr/>

## Illustration

Simplified illustration of the deployed stack:

<div style="text-align:center"><img src="https://cdn-images-1.medium.com/max/738/1*QqNjFvomy1ZcVnJ_y8yPrQ.png"/></div>

<hr/>

## Input/Output

### Input

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws-profile | The name of the AWS shared credentials account. | string | - | yes |
| aws-region | The AWS region | string | - | yes |
| alb-name | The application Load Balancer name | string | `app-load-balancer-w-terraform` | no |
| asg-def-size | The default/recommended size of the Auto Scaling Group | string | `3` | no |
| asg-max-size | The maximum size of the Auto Scaling Group | string | `4` | no |
| asg-min-size | The minimum size of the Auto Scaling Group | string | `2` | no |
| asg-name | The name of the Auto Scaling Group | string | `ASG-created-with-terraform` | no |
| domain-name | The apps public domain name | string | `` | no |
| environment | The environment (production/staging) | string | `staging` | no |
| iam-role-name | The IAM role to assign to the instance | string | `` | no |
| ig-tag-name | The name to apply to the Internet gateway tag | string | `aws-ig-created-with-terraform` | no |
| instance-ami | The AMI (Amazon Machine Image) that identifies the instance | string | `ami-01419b804382064e4` | no |
| instance-associate-public-ip | Defines if the EC2 instance has a public IP address. | string | `true` | no |
| instance-key-name | The name of the SSH key to associate to the instance. Note that the key must exist already. | string | `` | no |
| instance-tag-name | instance-tag-name | string | `EC2-instance-created-with-terraform` | no |
| instance-type | The instance type to be used | string | `t2.micro` | no |
| launch-config-name | The name of the launch configuration | string | `launch-configuration-created-with-terraform` | no |
| placement-group-name | The name of the placement group | string | `placement-group-created-w-terraform` | no |
| sg-alb-tag-name | The name of the SG associated with the ALB | string | `SG-to-theapp-load-balancer-with-terraform`| no |
| sg-tag-name | The Name to apply to the security group | string | `SG-created-with-terraform` | no |
| subnet-1-cidr-block | The CIDR block to associate to the subnet | string | `10.0.0.0/24` | no |
| subnet-2-cidr-block | The CIDR block to associate to the subnet | string | `10.0.1.0/24` | no |
| subnet-tag-name | The Name to apply to the VPN | string | `VPN-created-with-terraform` | no |
| target-group-name | The name of the placement group | string | `target-group-created-w-terraform` | no |
| user-data-script | The filepath to the user-data script, that is executed upon spinning up the instance | string | `` | no |
| vpc-cidr-block | The CIDR block to associate to the VPC | string | `10.0.0.0/16` | no |
| vpc-tag-name | The Name to apply to the VPC | string | `VPC-created-with-terraform` | no |

### Output

None

<hr/>

## Considerations

* Launch template vs launch configuration
  * changing the launch configuration leads to terraform errors
  * do launch templates behave differently?
  * if so, consider changing.

* add cloudfront distribution?

* are infrastructure changes reflected?

* are code changes (deployed to ECR) reflected on the environment?

* is it possible to use spot instances to reduce the costs?

* instances are still publicly accessible
  * they should be private
  * possible solution?
    * put instances in "private subnet" (subnet whose route table does not point to IGW)
    * route "private subnet" traffic to "public subnet" (or is it the other way around?)


