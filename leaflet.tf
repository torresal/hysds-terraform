provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  region                  = "${var.region}"
  profile              = "${var.profile}"
}


######################
# leaflet_server
######################

resource "aws_instance" "leaflet" {
  ami                    = "${var.leaflet["ami"]}"
  instance_type          = "${var.leaflet["instance_type"]}"
  key_name               = "${var.key_name}"
  availability_zone      = "${var.az}"
  tags                   = {
                             Name = "${var.project}-${var.venue}-${var.counter}-pcm-${var.leaflet["name"]}"
                           }
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  ebs_block_device {
    device_name = "${var.leaflet["docker_storage_dev"]}"
    volume_size = "${var.leaflet["docker_storage_dev_size"]}"
    volume_type = "gp2"
    delete_on_termination = true
  }
  ebs_block_device {
    device_name = "${var.leaflet["data_dev"]}"
    volume_size = "${var.leaflet["data_dev_size"]}"
    volume_type = "gp2"
    delete_on_termination = true
  }

  connection {
    type     = "ssh"
    user     = "ops"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.leaflet.private_ip} > leaflet_ip_address.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "git clone https://github.com/pymonger/docker-ephemeral-lvm.git",
      "cd docker-ephemeral-lvm/docker-ephemeral-lvm.d",
      "sudo bash docker-ephemeral-lvm.sh.no_encrypt_data",
      "sudo systemctl stop redis",
      "sudo mkdir -p ${var.leaflet["data"]}/var/lib",
      "sudo mv /var/lib/redis ${var.leaflet["data"]}/var/lib/",
      "sudo ln -sf ${var.leaflet["data"]}/var/lib/redis /var/lib/redis",
      "sudo systemctl start redis",
      "sudo bash -c \"echo ${lookup(var.leaflet, "data_dev_mount", var.leaflet["data_dev"])} ${var.leaflet["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\""
    ]
  }
}

output "leaflet_pvt_ip" {
  value = "${aws_instance.leaflet.private_ip}"
}

output "leaflet_pub_ip" {
  value = "${aws_instance.leaflet.public_ip}"
}