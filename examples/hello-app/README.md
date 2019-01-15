# Basic Hello-World app running on Auto Scaling Group

## Requirements

* You must have a valid AWS profile. Edit `terraform.tfvars` to use a valid AWS profile. 
  
<hr/>

## Usage

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
 
* this module deploys one EC2 instance  
  * upon start, the machine runs the *deploy-hello-node.js* script, which  
  * pulls and runs the *[Hello-World docker app](https://hub.docker.com/r/rafaelmarques7/hello-node)*.
  * the instance is not configured with an SSH key, so logging into the instance is not possible.
* the app is acessible via load-balancer DNS.
* the app is accessible via instance public ip (will be removed in future versions). 
* AMI's are region specific
  * if you change the region, you must change the AMI
  