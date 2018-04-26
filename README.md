# hysds-terraform
HySDS cluster provisioning using Terraform

## Prerequisites
1. Install Terraform from https://www.terraform.io/. You can run `terraform` from any machine or your laptop.
1. If you are using AWS, make sure you have your credentials setup up. To set them up, install the AWS CLI from https://aws.amazon.com/cli/ and run `aws configure`.

## Usage
1. First initialize so plugins are installed:
   ```
   cd hysds-terraform
   terraform init
   ```
1. Copy the variables.tf.tmpl to variables.tf:
   ```
   cp variables.tf.tmpl variables.tf
   ```
1. Updated the values starting with two underscores, e.g. \_\_region\_\_, for your provider account and settings.
1. Validate your configuration:
   ```
   terraform validate --var shared_credentials_file=~/.aws/credentials \
     --var profile=default --var venue=ops
   ```
1. Build your HySDS clustser:
   ```
   terraform apply --var shared_credentials_file=~/.aws/credentials \
     --var profile=default --var venue=ops
   ```
1. Show status of your HySDS cluster:
   ```
   terraform show --var shared_credentials_file=~/.aws/credentials \
     --var profile=default --var venue=ops
   ```
1. Destroy your HySDS cluster once it's no longer needed:
   ```
   terraform destroy --var shared_credentials_file=~/.aws/credentials \
     --var profile=default --var venue=ops
   ```
