# hysds-terraform
HySDS cluster provisioning using Terraform

## Prerequisites
1. Install Terraform from https://www.terraform.io/. You can run `terraform` from any machine or your laptop.
2. If you are using Google Cloud Platform (GCP), make sure you have your credentials setup up. To set them up, install the [Cloud SDK](https://cloud.google.com/sdk/docs/quickstarts) for your system and run `gcloud init`.

## Usage
1. Clone the repo
   ```
   git clone https://github.com/hysds/hysds-terraform.git
   cd hysds-terraform
   ```
1. Copy the gcp-variables.tf.tmpl to variables.tf:
   ```
   cp gcp-variables.tf.tmpl variables.tf
   ```
   1. Initialize so plugins are installed:
   ```
   terraform init
   ```
1. Updated the values starting with two underscores, e.g. \_\_region\_\_, for your provider account and settings. Edit the variables.tf file with custom variables for this installation venue. Many of these values can be acquired from the GCP console.
   ```
   vi variables.tf
   ```
1. Determine the `project`, `venue` and `counter` for your HySDS cluster. They will be used to uniquely name and identify your cluster's resources. The `project` is the project ID of your GCP account project you would like to use. You can list the avaliable projects using the command `gcloud projects list`.

   - `project` e.g. gcp-project-12345
   - `venue` e.g. ops, dev, test, gerald
   - `counter` e.g. 1, 2, 3
   
1. Validate your configuration:
   ```
   terraform validate --var project=gcp-project-12345 --var venue=ops --var counter=1
   ```
1. Build your HySDS clustser:
   ```
   terraform apply --var project=gcp-project-12345 --var venue=ops --var counter=1
   ```
1. Show status of your HySDS cluster:
   ```
   terraform show --var project=gcp-project-12345 --var venue=ops --var counter=1
   ```
1. Destroy your HySDS cluster once it's no longer needed:
   ```
   terraform destroy --var project=gcp-project-12345 --var venue=ops --var counter=1
   ```
