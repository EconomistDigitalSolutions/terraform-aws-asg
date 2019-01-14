# Terraform-aws-asg

This module provisions the necessary resources to run a (docker) application in an Auto Scaling Group (ASG) of EC2 instances. This module should be production ready.


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

&nbsp;

Illustration (simplified) of the deployed stack:

<div style="text-align:center"><img src="https://cdn-images-1.medium.com/max/738/1*QqNjFvomy1ZcVnJ_y8yPrQ.png"/></div>

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


