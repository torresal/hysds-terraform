
# globals
variable "project" {
  default = "first-project-204916"
}
variable "venue" {
  default = "provisioned"
}
variable "counter" {
  default = 1
}

variable "credentials_file_path" {
  default = "~/.config/gcloud/gcp-credentials.json"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/APT-GCP.pub"
}

variable "region" {
  default = "us-east4"
}

variable "zone" {
  default = "us-east4-b"
}

variable "image" {
  default = "centos-7-v20180523"
}

# mozart vars
variable "mozart" {
  type = "map"
  default = {
    name = "mozart"
    image = "centos-7-v20180523"
    machine_type = "n1-standard-1"
  }
}

# metrics vars
variable "metrics" {
  type = "map"
  default = {
    name = "metircs"
    image = "centos-7-v20180523"
    machine_type = "n1-standard-1"
  } 
}

# grq vars
variable "grq" {
  type = "map"
  default = {
    name = "grq"
    image = "centos-7-v20180523"
    machine_type = "n1-standard-1"
  } 
}

# factotum vars
variable "factotum" {
  type = "map"
  default = {
    name = "factotum"
    image = "centos-7-v20180523"
    machine_type = "n1-standard-1"
  } 
}

# ci vars
variable "ci" {
  type = "map"
  default = {
    name = "ci"
    image = "centos-7-v20180523"
    machine_type = "n1-standard-1"
  } 
}

# autoscale vars
variable "autoscale" {
  type = "map"
  default = {
    name = "autoscale"
    image = "centos-7-v20180523"
    machine_type = "n1-standard-1"
  } 
}
