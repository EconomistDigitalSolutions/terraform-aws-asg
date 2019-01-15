# Basic Hello-World app running on Auto Scaling Group

## Requirements

* You must have a valid AWS profile. Edit `terraform.tfvars` to use a valid AWS profile. 
  
<hr/>

## Usage

0) Edit `terraform.tfvars`. In particular, specify a valid AWS account.

    0.1) Feel free to edit `_main.tf` to use the number of machines you want. 

1) Provision the infrastructure (and deploy the app on instance start):
    ```
    terraform init; terraform apply --auto-approve
    ```
    1.1) Case you change any part of the infrastructure, repeat step 1).

2) To tear down the infrastructure, run:
    ```
    terraform init; terraform destroy --auto-approve
    ```

<hr/>

## Notes
 
* this module deploys an Auto Scaling Group  
  * the number of machines running varies between 2 and 5 (defaults to 3).
  * upon start, each machine runs the *deploy-hello-node.js* script, which  
  * pulls and runs the *[Hello-World docker app](https://hub.docker.com/r/rafaelmarques7/hello-node)*.
  * no instance is configured with an SSH key, so logging into the instances is not possible.
* the app is acessible via load-balancer DNS.
* the app is accessible via each instance's public ip (will be removed in future versions). 
* AMI's are region specific
  * if you change the region, you must change the AMI
* this application is **not** covered by the AWS free tier.
  * destroy the resources as soon as you do not need them anymore  