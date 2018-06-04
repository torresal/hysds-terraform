# Configure the Google Cloud provider
  provider "google" {
  region      = "${var.region}"
  project     = "${var.project}"
  credentials = "${file("${var.credentials_file_path}")}"
}
 
# Create a new instance
  resource "google_compute_instance" "default" {
  count = "${var.counter}"

  name = "apt-test-instance"
  machine_type = "f1-micro"
  zone = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

}
