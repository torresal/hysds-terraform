# hysds-terraform
HySDS cluster provisioning using Terraform

## Prerequisites
1. Install Terraform from https://www.terraform.io/. You can run `terraform` from any machine or your laptop.
1. If you are using AWS, make sure you have your credentials setup up. To set them up, install the AWS CLI from https://aws.amazon.com/cli/ and run `aws configure`.

## Usage
1. Clone the repo
   ```
   git clone https://github.com/hysds/hysds-terraform.git
   ```
1. First initialize so plugins are installed:
   ```
   cd hysds-terraform
   terraform init
   ```
1. Copy the variables.tf.templ to variables.tf:
   ```
   cp variables.tf.templ variables.tf
   ```
1. Updated the values starting with two underscores, e.g. \_\_region\_\_, for your provider account and settings.
1. Determine the `project`, `venue` and `counter` for your HySDS cluster. They will be used to uniquely name and identify your cluster's resources.
   - `project` e.g. swot, smap, aria, grfn, eos
   - `venue` e.g. ops, dev, test, gerald
   - `counter` e.g. 1, 2, 3
1. Validate your configuration:
   ```
   terraform validate --var project=aria --var venue=ops --var counter=1
   ```
1. Build your HySDS clustser:
   ```
   terraform apply --var project=aria --var venue=ops --var counter=1
   ```
1. Show status of your HySDS cluster:
   ```
   terraform show --var project=aria --var venue=ops --var counter=1
   ```
1. Destroy your HySDS cluster once it's no longer needed:
   ```
   terraform destroy --var project=aria --var venue=ops --var counter=1
   ```
