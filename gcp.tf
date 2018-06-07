# Configure the Google Cloud provider

provider "google" {
region      = "${var.region}"
project     = "${var.project}"
credentials = "${file("${var.credentials_file_path}")}"
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
  network = "default"
  access_config {}
 }

service_account {
  scopes = ["https://www.googleapis.com/auth/compute.readonly"]
 }

metadata {
  ssh-keys = "root:${file("${var.public_key_path}")}"
 }

provisioner "remote-exec" {
  inline = [
    "sudo su -",
    "yum install -y git",
    "yum install -y puppet",
    "yum install -y puppet-firewalld",
    "bash < <(curl -skL https://github.com/hysds/puppet-mozart/raw/master/install.sh)"	
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
tags = ["${var.project}-${var.venue}-${var.counter}-pcm-${var.metrics["name"]}"]

boot_disk {
  initialize_params {
    image = "${var.metrics["image"]}"
  }
 }

network_interface {
  network = "default"
  access_config {}
 }

service_account {
  scopes = ["https://www.googleapis.com/auth/compute.readonly"]
 }

metadata {
  ssh-keys = "root:${file("${var.public_key_path}")}"
 }

provisioner "remote-exec" {
  inline = [
    "sudo su -",
    "yum install -y git",
    "yum install -y puppet",
    "yum install -y puppet-firewalld",
    "bash < <(curl -skL https://github.com/hysds/puppet-metrics/raw/master/install.sh)"
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
  network = "default"
  access_config {}
 }

service_account {
  scopes = ["https://www.googleapis.com/auth/compute.readonly"]
 }

metadata {
  ssh-keys = "root:${file("${var.public_key_path}")}"
 }

provisioner "remote-exec" {
  inline = [
    "sudo su -",
    "yum install -y git",
    "yum install -y puppet",
    "yum install -y puppet-firewalld",
    "bash < <(curl -skL https://github.com/hysds/puppet-grq/raw/master/install.sh)"
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
tags = ["${var.project}-${var.venue}-${var.counter}-pcm-${var.factotum["name"]}"]

boot_disk {
  initialize_params {
    image = "${var.factotum["image"]}"
  }
 }

network_interface {
  network = "default"
  access_config {}
 }

service_account {
  scopes = ["https://www.googleapis.com/auth/compute.readonly"]
 }

metadata {
  ssh-keys = "root:${file("${var.public_key_path}")}"
 }

provisioner "remote-exec" {
  inline = [
    "sudo su -",
    "yum install -y git",
    "yum install -y puppet",
    "yum install -y puppet-firewalld",
    "bash < <(curl -skL https://github.com/hysds/puppet-factotum/raw/master/install.sh)"
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
  network = "default"
  access_config {}
 }

service_account {
  scopes = ["https://www.googleapis.com/auth/compute.readonly"]
 }

metadata {
  ssh-keys = "root:${file("${var.public_key_path}")}"
 }

provisioner "remote-exec" {
  inline = [
    "sudo su -",
    "yum install -y git",
    "yum install -y puppet",
    "yum install -y puppet-firewalld",
    "bash < <(curl -skL https://github.com/hysds/puppet-cont_int/raw/master/install.sh)"
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
  network = "default"
  access_config {}
 }

service_account {
  scopes = ["https://www.googleapis.com/auth/compute.readonly"]
 }

metadata {
  ssh-keys = "root:${file("${var.public_key_path}")}"
 }

}
