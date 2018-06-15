
# globals
variable "project" {
  default = "first-project-204916"
}
variable "venue" {
  default = "test"
}
variable "counter" {
  default = 1
}

variable "credentials_file_path" {
  default = "~/.config/gcloud/gcp-credentials.json"
}

variable "user" {
  description = "username for ssh login"
  default = "ops"
}

variable "password" {
  description = "password for ssh key pair"
  default = ""
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/OPS.pub"
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "~/.ssh/OPS"
}

variable "region" {
  default = "us-east4"
}

variable "zone" {
  default = "us-east4-b"
}

# mozart vars
variable "mozart" {
  type = "map"
  default = {
    name = "mozart"
    image = "hysds-centos7-mozart"
    machine_type = "n1-standard-1"
    data = "/data"
    data_dev = "/dev/xvdb"
    data_dev_size = 50
    data2 = "/data2"
    data2_dev = "/dev/xvdc"
    data2_dev_size = 50    
  }
}

# metrics vars
variable "metrics" {
  type = "map"
  default = {
    name = "metircs"
    image = "hysds-centos7-metrics"
    machine_type = "n1-standard-1"
    data = "/data"
    data_dev = "/dev/xvdb"
    data_dev_size = 100
  } 
}

# grq vars
variable "grq" {
  type = "map"
  default = {
    name = "grq"
    image = "hysds-centos7-grq"
    machine_type = "n1-standard-1"
    data = "/data"
    data_dev = "/dev/xvdb"
    data_dev_size = 100
  } 
}

# factotum vars
variable "factotum" {
  type = "map"
  default = {
    name = "factotum"
    image = "hysds-centos7-factotum"
    machine_type = "n1-standard-1"
    docker_storage_dev = "/dev/xvdb"
    docker_storage_dev_size = 50
    data = "/data"
    data_dev = "/dev/xvdc"
    data_dev_mount = "/dev/nvme2n1"
    data_dev_size = 300
  } 
}

# ci vars
variable "ci" {
  type = "map"
  default = {
    name = "ci"
    image = "hysds-centos7-ci"
    machine_type = "n1-standard-1"
    docker_storage_dev = "/dev/xvdb"
    docker_storage_dev_size = 50
    data = "/data"
    data_dev = "/dev/xvdc"
    data_dev_mount = "/dev/nvme2n1"
    data_dev_size = 100
  } 
}

# autoscale vars
variable "autoscale" {
  type = "map"
  default = {
    name = "autoscale"
    image = "hysds-centos7-autoscale"
    machine_type = "n1-standard-1"
    docker_storage_dev = "/dev/xvdb"
    docker_storage_dev_size = 50
    data = "/data"
    data_dev = "/dev/xvdc"
    data_dev_mount = "/dev/nvme2n1"
    data_dev_size = 300
  } 
}
