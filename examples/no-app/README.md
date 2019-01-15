# Deploy Auto Scaling Infrastructure but run no application

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

* this is an "useless" example:
  * it deploy AWS infrastructure 
  * but no application that runs on it
* this application is **not** covered by the AWS free tier.
  * destroy the resources as soon as you do not need them anymore  
  
