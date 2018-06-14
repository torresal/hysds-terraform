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
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/gcp-credentials.json"

  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }
 }


provisioner "remote-exec" {
  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }

  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/gcp-credentials.json gcloud/"
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
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/gcp-credentials.json"

  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }
 }

provisioner "remote-exec" {
  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }

  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/gcp-credentials.json gcloud/"
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
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/gcp-credentials.json"

  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }
 }

provisioner "remote-exec" {
  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }

  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/gcp-credentials.json gcloud/"
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
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/gcp-credentials.json"

  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }
 }

provisioner "remote-exec" {
  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }

  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/gcp-credentials.json gcloud/"
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
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

provisioner "file" {
  source          = "${var.credentials_file_path}"
  destination     = "/tmp/gcp-credentials.json"

  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }
 }

provisioner "remote-exec" {
  connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
      timeout     = "2m"
    }

  inline = [
    "cd ~",
    "sudo mkdir gcloud/",
    "sudo mv /tmp/gcp-credentials.json gcloud/"
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
  ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
 }

}
