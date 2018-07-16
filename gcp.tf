# Configure the Google Cloud provider

provider "google" {
region      = "${var.region}"
project     = "${var.project}"
# credentials = "${file("${var.credentials_file_path}")}"
}
 
# Create new instances

######################
#        Mozart
######################

resource "google_compute_instance" "mozart" {
name = "${var.project}-${var.venue}-${var.counter}-pcm-${var.mozart["name"]}"
machine_type = "${var.mozart["machine_type"]}"
zone = "${var.zone}"
tags = ["${var.project}-${var.venue}-${var.counter}-pcm-${var.mozart["name"]}"]


boot_disk {
  initialize_params {
    image = "${var.mozart["image"]}"
  }
 }

network_interface {
  network = "${var.network}"
  access_config {}
 }

service_account {
  email = "${var.service_account}",
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
 }

metadata {
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

connection {
  type        = "ssh"
  user        = "${var.user}"
  password    = "${var.password}"
  private_key = "${file("${var.private_key_path}")}"
  agent       = false
  timeout     = "2m"
 }

provisioner "remote-exec" {
  inline = [
    "gcloud config set account ${var.service_account}"
  ]
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/config_default"
 }

provisioner "file" {
  source          = "${var.private_key_path}"
  destination     = "/tmp/OPS"
 }

provisioner "remote-exec" {
  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/config_default.json gcloud/",
    "sudo mv /tmp/OPS ~/.ssh/",
    "sudo chmod 400 ~/.ssh/OPS"
  ]
 }

provisioner "remote-exec" {
  inline = [
    "sudo mkfs.xfs ${var.mozart["data_dev"]}",
    "sudo bash -c \"echo ${lookup(var.mozart, "data_dev_mount", var.mozart["data_dev"])} ${var.mozart["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\"",
    "sudo mkdir -p ${var.mozart["data"]}",
    "sudo mount ${var.mozart["data"]}",
    "sudo chown -R ops:ops ${var.mozart["data"]}",
    "sudo mkfs.xfs ${var.mozart["data2_dev"]}",
    "sudo bash -c \"echo ${lookup(var.mozart, "data2_dev_mount", var.mozart["data2_dev"])} ${var.mozart["data2"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\"",
    "sudo mkdir -p ${var.mozart["data2"]}",
    "sudo mount ${var.mozart["data2"]}",
    "sudo chown -R ops:ops ${var.mozart["data2"]}",
    "sudo mkdir -p ${var.mozart["data"]}/var/lib",
    "sudo systemctl stop elasticsearch",
    "sudo systemctl stop redis",
    "sudo systemctl stop rabbitmq-server",
    "sudo mv /var/lib/elasticsearch ${var.mozart["data"]}/var/lib/",
    "sudo ln -sf ${var.mozart["data"]}/var/lib/elasticsearch /var/lib/elasticsearch",
    "sudo mv /var/lib/redis ${var.mozart["data"]}/var/lib/",
    "sudo ln -sf ${var.mozart["data"]}/var/lib/redis /var/lib/redis",
    "sudo mv /var/lib/rabbitmq ${var.mozart["data"]}/var/lib/",
    "sudo ln -sf ${var.mozart["data"]}/var/lib/rabbitmq /var/lib/rabbitmq",
    "sudo systemctl start elasticsearch",
    "sudo systemctl start redis",
    "sudo systemctl start rabbitmq-server"
  ]
 }
}

######################
#        Metrics
######################

resource "google_compute_instance" "metrics" {
name = "${var.project}-${var.venue}-${var.counter}-pcm-${var.metrics["name"]}"
machine_type = "${var.metrics["machine_type"]}"
zone = "${var.zone}"
tags =["${var.project}-${var.venue}-${var.counter}-pcm-${var.metrics["name"]}"]

boot_disk {
  initialize_params {
    image = "${var.metrics["image"]}"
  }
 }

network_interface {
  network = "${var.network}"
  access_config {}
 }

service_account {
  email = "${var.service_account}",
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
 }

metadata {
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

connection {
  type        = "ssh"
  user        = "${var.user}"
  password    = "${var.password}"
  private_key = "${file("${var.private_key_path}")}"
  agent       = false
  timeout     = "2m"
 }

provisioner "remote-exec" {
  inline = [
    "gcloud config set account ${var.service_account}"
  ]
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/config_default"
 }

provisioner "remote-exec" {
  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/config_default gcloud/"
  ]
 }

provisioner "remote-exec" {
  inline = [
    "sudo mkfs.xfs ${var.metrics["data_dev"]}",
    "sudo bash -c \"echo ${lookup(var.metrics, "data_dev_mount", var.metrics["data_dev"])} ${var.metrics["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\"",
    "sudo mkdir -p ${var.metrics["data"]}",
    "sudo mount ${var.metrics["data"]}",
    "sudo chown -R ops:ops ${var.metrics["data"]}",
    "sudo systemctl stop elasticsearch",
    "sudo systemctl stop redis",
    "sudo mkdir -p ${var.metrics["data"]}/var/lib",
    "sudo mv /var/lib/elasticsearch ${var.metrics["data"]}/var/lib/",
    "sudo ln -sf ${var.metrics["data"]}/var/lib/elasticsearch /var/lib/elasticsearch",
    "sudo mv /var/lib/redis ${var.metrics["data"]}/var/lib/",
    "sudo ln -sf ${var.metrics["data"]}/var/lib/redis /var/lib/redis",
    "sudo systemctl start elasticsearch",
    "sudo systemctl start redis"
  ]
 }
}

######################
#        GRQ
######################

resource "google_compute_instance" "grq" {
name = "${var.project}-${var.venue}-${var.counter}-pcm-${var.grq["name"]}"
machine_type = "${var.grq["machine_type"]}"
zone = "${var.zone}"
tags = ["${var.project}-${var.venue}-${var.counter}-pcm-${var.grq["name"]}"]

boot_disk {
  initialize_params {
    image = "${var.grq["image"]}"
  }
 }

network_interface {
  network = "${var.network}"
  access_config {}
 }

service_account {
  email = "${var.service_account}",
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
 }

metadata {
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

connection {
  type        = "ssh"
  user        = "${var.user}"
  password    = "${var.password}"
  private_key = "${file("${var.private_key_path}")}"
  agent       = false
  timeout     = "2m"
 }

provisioner "remote-exec" {
  inline = [
    "gcloud config set account ${var.service_account}"
  ]
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/config_default"
 }

provisioner "remote-exec" {
  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/config_default gcloud/"
  ]
 }

provisioner "remote-exec" {
  inline = [
    "sudo mkfs.xfs ${var.grq["data_dev"]}",
    "sudo bash -c \"echo ${lookup(var.grq, "data_dev_mount", var.grq["data_dev"])} ${var.grq["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\"",
    "sudo mkdir -p ${var.grq["data"]}",
    "sudo mount ${var.grq["data"]}",
    "sudo chown -R ops:ops ${var.grq["data"]}",
    "sudo systemctl stop elasticsearch",
    "sudo systemctl stop redis",
    "sudo mkdir -p ${var.grq["data"]}/var/lib",
    "sudo mv /var/lib/redis ${var.grq["data"]}/var/lib/",
    "sudo ln -sf ${var.grq["data"]}/var/lib/redis /var/lib/redis",
    "sudo systemctl start redis",
    "(sudo mv /var/lib/elasticsearch ${var.grq["data"]}/var/lib/ && sudo ln -sf ${var.grq["data"]}/var/lib/elasticsearch /var/lib/elasticsearch && sudo systemctl start elasticsearch) &"
  ]
 }
}

######################
#      Factotum
######################

resource "google_compute_instance" "factotum" {
name = "${var.project}-${var.venue}-${var.counter}-pcm-${var.factotum["name"]}"
machine_type = "${var.factotum["machine_type"]}"
zone = "${var.zone}"
tags =["${var.project}-${var.venue}-${var.counter}-pcm-${var.factotum["name"]}"]

boot_disk {
  initialize_params {
    image = "${var.factotum["image"]}"
  }
 }

network_interface {
  network = "${var.network}"
  access_config {}
 }

service_account {
  email = "${var.service_account}",
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
 }

metadata {
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

connection {
  type        = "ssh"
  user        = "${var.user}"
  password    = "${var.password}"
  private_key = "${file("${var.private_key_path}")}"
  agent       = false
  timeout     = "2m"
 }

provisioner "remote-exec" {
  inline = [
    "gcloud config set account ${var.service_account}"
  ]
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/config_default"
 }

provisioner "remote-exec" {
  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/config_default gcloud/"
  ]
 }

provisioner "remote-exec" {
  inline = [
    "cd /tmp",
    "git clone https://github.com/pymonger/docker-ephemeral-lvm.git",
    "cd docker-ephemeral-lvm/docker-ephemeral-lvm.d",
    "sudo bash docker-ephemeral-lvm.sh.no_encrypt_data",
    "sudo systemctl stop redis",
    "sudo mkdir -p ${var.factotum["data"]}/var/lib",
    "sudo mv /var/lib/redis ${var.factotum["data"]}/var/lib/",
    "sudo ln -sf ${var.factotum["data"]}/var/lib/redis /var/lib/redis",
    "sudo systemctl start redis",
    "sudo bash -c \"echo ${lookup(var.factotum, "data_dev_mount", var.factotum["data_dev"])} ${var.factotum["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\""
  ]
 }
}

######################
#        CI
######################

resource "google_compute_instance" "ci" {
name = "${var.project}-${var.venue}-${var.counter}-pcm-${var.ci["name"]}"
machine_type = "${var.ci["machine_type"]}"
zone = "${var.zone}"
tags = ["${var.project}-${var.venue}-${var.counter}-pcm-${var.ci["name"]}"]

boot_disk {
  initialize_params {
    image = "${var.ci["image"]}"
  }
 }

network_interface {
  network = "${var.network}"
  access_config {}
 }

service_account {
  email = "${var.service_account}",
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
 }

metadata {
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

connection {
  type        = "ssh"
  user        = "${var.user}"
  password    = "${var.password}"
  private_key = "${file("${var.private_key_path}")}"
  agent       = false
  timeout     = "2m"
 }

provisioner "remote-exec" {
  inline = [
    "gcloud config set account ${var.service_account}"
  ]
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/config_default"
 }

provisioner "remote-exec" {
  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/config_default gcloud/"
  ]
 }

provisioner "remote-exec" {
  inline = [
    "cd /tmp",
    "git clone https://github.com/pymonger/docker-ephemeral-lvm.git",
    "cd docker-ephemeral-lvm/docker-ephemeral-lvm.d",
    "sudo bash docker-ephemeral-lvm.sh.no_encrypt_data",
    "sudo bash -c \"echo ${lookup(var.ci, "data_dev_mount", var.ci["data_dev"])} ${var.ci["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\""
  ]
 }
}

######################
#      Autoscale
######################

resource "google_compute_instance" "autoscale" {
name = "${var.project}-${var.venue}-${var.counter}-pcm-${var.autoscale["name"]}"
machine_type = "${var.autoscale["machine_type"]}"
zone = "${var.zone}"
tags = ["${var.project}-${var.venue}-${var.counter}-pcm-${var.autoscale["name"]}"]

boot_disk {
  initialize_params {
    image = "${var.autoscale["image"]}"
  }
 }

network_interface {
  network = "${var.network}"
  access_config {}
 }

service_account {
  email = "${var.service_account}",
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
 }

metadata {
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

connection {
  type        = "ssh"
  user        = "${var.user}"
  password    = "${var.password}"
  private_key = "${file("${var.private_key_path}")}"
  agent       = false
  timeout     = "2m"
 }

provisioner "remote-exec" {
  inline = [
    "gcloud config set account ${var.service_account}"
  ]
 }

provisioner "remote-exec" {
  inline = [
    "cd /tmp",
    "git clone https://github.com/pymonger/docker-ephemeral-lvm.git",
    "cd docker-ephemeral-lvm/docker-ephemeral-lvm.d",
    "sudo bash docker-ephemeral-lvm.sh.no_encrypt_data",
    "sudo bash -c \"echo ${lookup(var.autoscale, "data_dev_mount", var.autoscale["data_dev"])} ${var.autoscale["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\""
  ]
 }
}
