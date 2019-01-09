# Terraform for EC2 instances

This module intends to provision all the resources that are necessary to run an application on an EC2 instance, in a production environment. This module is an extension of the `terraform-aws-ec2` module. These differences include: -a load balancer; - CloudFront distribution; - domain name;

# Situation

Currently in the load balacer example, we are able to create a load balancer, and provision it accoridng to [this article](https://medium.com/cognitoiq/terraform-and-aws-application-load-balancers-62a6f8592bcf), but we are not able to get a proper response.

...

5 seconds later, goes back there, and it works!
why?
it did not work on any previous occasion.
Does it take some time???

