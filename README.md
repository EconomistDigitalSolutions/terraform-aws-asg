# Terraform/AWS Auto Scaling Module

This module provisions the resources necessary to run a (docker) application in an Auto Scaling Group (ASG) of EC2 instances. This module should be production ready. This module is available in the [terraform registry](https://registry.terraform.io/modules/EconomistDigitalSolutions/asg/aws/)

## Table of contents

- [Terraform/AWS Auto Scaling Module](#terraformaws-auto-scaling-module)
  - [Table of contents](#table-of-contents)
  - [WWH - What, Why, How](#wwh---what-why-how)
  - [Usage](#usage)
  - [Bugs/Known Issues](#bugsknown-issues)
  - [Implementation details](#implementation-details)
  - [Illustration](#illustration)
  - [Input/Output](#inputoutput)
    - [Inputs](#inputs)
    - [Outputs](#outputs)
  - [Considerations](#considerations)
  - [ToDo's](#todos)

<hr/>

## WWH - What, Why, How

* **What?** Deploys, manages and destroys the AWS resources necessary to run applications in an Auto Scaling Group of EC2 instances

* **Why?** Auto Scaling Groups enable the infrastructure to be adjusted to the application load. Re-usable module. 

* **How?** This module deploys all stacks of the required infrastructure. To run an application on the infrastructure, it is necessary to provide a deployment script for the containerized application. 

<hr/>

## Usage

To use this module, it is advised to carefully follow these instructions: 

1) Create a repository for your project
   ```
   mkdir my-app; cd my-app
   ```

2) Create and edit `_main.tf`:
    ```
    module "terraform-aws-asg" {
      source = "../../module"

      aws-region        = "eu-west-1"
      aws-profile       = "your-aws-profile"
      user-data-script  = "path-to-deployment-script"
      instance-key-name = "ssh-key"
      asg-min-size      = "2"
      asg-max-size      = "5"
      asg-def-size      = "2"
    }
    ```

3) Provision the infrastructure (and deploy the app on instance start):
    ```
    terraform init; terraform apply --auto-approve
    ```
 
4) Case you change any part of the infrastructure, repeat step 3).

5) To tear down the infrastructure, run
    ```
    terraform init; terraform destroy --auto-approve
    ```


<hr />


## Bugs/Known Issues

* when changing region - can not migrate load-balancer
  * this issue is currently open on:
    * stackoverflow [https://stackoverflow.com/questions/54650350/aws-load-balancer-change-region-with-terraform](https://stackoverflow.com/questions/54650350/aws-load-balancer-change-region-with-terraform)
    * Terraform [https://github.com/terraform-providers/terraform-provider-aws/issues/7517](https://github.com/terraform-providers/terraform-provider-aws/issues/7517)

* Multiple concurrent deployments mya lead to issues with the terraform state lock, creating a race condition and possibly stale deployments;
* Once Cloudfront is set up, tearing it down will cause downtime;
  * This issue was [raised in StackExchange](https://devops.stackexchange.com/questions/8368/terraform-route53-lb-and-cdn-interdependencies), and there is thorough answer with very useful advice.
* New deployments follow Blue/Green approach. A new Auto Scaling Group is created on every deployments. The teardown of the old ASG takes a long time (approx. 7 minutes).
* In order to trigger a new deployment, the user-data script **must** change (even a newline is enough)
* This module is a "all-in-one" solution for the Web Products infrastructure. Terraform advices against this, and recommends a modular approach (similar to what you would do with React on the FrontEnd).
* The Amazon Machine Image (AMI) lookup is limited to Amazon Linux.


<hr />


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


### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb-name | The application Load Balancer name | string | `"app-load-balancer-w-terraform"` | no |
| asg-def-size | The default/recommended size of the Auto Scaling Group | string | `"3"` | no |
| asg-max-size | The maximum size of the Auto Scaling Group | string | `"4"` | no |
| asg-min-size | The minimum size of the Auto Scaling Group | string | `"2"` | no |
| asg-name | The name of the Auto Scaling Group | string | `"ASG-created-with-terraform"` | no |
| aws-profile | The name of the AWS shared credentials account. | string | n/a | yes |
| aws-region | The AWS region | string | n/a | yes |
| cfd\_default\_max\_ttl | The maximum TTL of the default cache behaviour | string | `"86400"` | no |
| cfd\_default\_regular\_ttl | The (regular) TTL of the default cache behaviour | string | `"3600"` | no |
| cfd\_ordered\_max\_ttl | The maximum TTL of the ordered cache behaviour(es) | string | `"86400"` | no |
| cfd\_ordered\_regular\_ttl | The (regular) TTL of the ordered cache behaviour(es) | string | `"3600"` | no |
| domain-name | The apps public domain name | string | `""` | no |
| emergency-contact | The apps public sub domain name | string | `""` | no |
| environment | The environment (production/staging) | string | `"staging"` | no |
| git-hash | The apps public sub domain name | string | `""` | no |
| health-check-path | The apps public sub domain name | string | `"/"` | no |
| health-check-port | The apps public sub domain name | string | `"80"` | no |
| health\_check\_grace\_period | Time (in seconds) after instance comes into service before checking health. | string | `"3"` | no |
| health\_check\_interval | The interval between health checks | string | `"5"` | no |
| health\_check\_threshold | The number of consecutive health checks to be considered (un)healthy. | string | `"3"` | no |
| iam-role-name | The IAM role to assign to the instance | string | `""` | no |
| ig-tag-name | The name to apply to the Internet gateway tag | string | `"aws-ig-created-with-terraform"` | no |
| instance-ami | The AMI (Amazon Machine Image) that identifies the instance | string | `"ami-01419b804382064e4"` | no |
| instance-associate-public-ip | Defines if the EC2 instance has a public IP address. | string | `"true"` | no |
| instance-key-name | The name of the SSH key to associate to the instance. Note that the key must exist already. | string | `""` | no |
| instance-tag-name | instance-tag-name | string | `"EC2-instance-created-with-terraform"` | no |
| instance-type | The instance type to be used | string | `"t2.micro"` | no |
| launch-config-name | The name of the launch configuration | string | `"launch-configuration-created-with-terraform"` | no |
| owner | The apps public sub domain name | string | `""` | no |
| placement-group-name | The name of the placement group | string | `"placement-group-created-w-terraform"` | no |
| product | The apps public sub domain name | string | `""` | no |
| project | The apps public sub domain name | string | `""` | no |
| s3\_bucket\_for\_cloudfront\_logs | The name of the S3 bucket that holds the cloudfront logs | string | `""` | no |
| sg-alb-tag-name | The name of the SG associated with the ALB | string | `"SG-to-theapp-load-balancer-with-terraform"` | no |
| sg-tag-name | The Name to apply to the security group | string | `"SG-created-with-terraform"` | no |
| ssh-allowed-ips | The list of IPs that are allowed to SSH into the instances | list | `<list>` | no |
| ssl\_certificate\_arn | The ARN of the SSL certificate for the load-balancer | string | `""` | no |
| sub-domain-name | The apps public sub domain name | string | `""` | no |
| subnet-1-cidr-block | The CIDR block to associate to the subnet | string | `"10.0.0.0/24"` | no |
| subnet-2-cidr-block | The CIDR block to associate to the subnet | string | `"10.0.1.0/24"` | no |
| subnet-tag-name | The Name to apply to the VPN | string | `"VPN-created-with-terraform"` | no |
| target-group-name | The name of the placement group | string | `"lb-tg"` | no |
| use\_cloudfront | If true, will create a CFD distribution | string | `"false"` | no |
| use\_https\_only | If true, forces all http traffic to https | string | `"false"` | no |
| user-data-script | The filepath to the user-data script, that is executed upon spinning up the instance | string | `""` | no |
| vpc-cidr-block | The CIDR block to associate to the VPC | string | `"10.0.0.0/16"` | no |
| vpc-tag-name | The Name to apply to the VPC | string | `"VPC-created-with-terraform"` | no |

### Outputs

| Name | Description |
|------|-------------|
| domain-cloudfront-distribution | The public domain of the cloudfront distribution |
| domain-load-balancer | The public domain of the load-balancer |

<hr/>

## Considerations

* ~~Consider the addition of CloudFront Distribution (CFD) to serve as a Content Distribution Network (CDN)~~.

* Consider the usage of Spot Instances to reduce costs.
  
* ~~Assert that code changes are reflected on the app running on AWS.~~
  * this is live from version v1.0.5 onwards, **as long as the user-data script changes.**

* ~~Consider moving the instances to a private subnet.~~
  * this is live from version v1.0.5 onwards

* ~~changing the AWS region requires changing the machine AMI.~~
  * this was fixed from version v1.0.6 onwards, **but it is limited to the use of Amazon Linux only**

* ~~add tagging utilities~~
  * this is fixed from version v1.0.7 onwards, trought the use of the *locals*


<hr/>

## ToDo's

* add outputs
