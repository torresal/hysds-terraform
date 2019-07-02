provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  region                  = "${var.region}"
  profile              = "${var.profile}"
}


#################
# leaflet_server
#################
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
    host = self.private_ip
    user     = "ops"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.leaflet.private_ip} > leaflet_ip_address.txt"
  }

  provisioner "remote-exec" {
    inline = [
      # provision verdi
      "cd /tmp",
      "git clone https://github.com/pymonger/docker-ephemeral-lvm.git",
      "cd docker-ephemeral-lvm/docker-ephemeral-lvm.d",
      "sudo bash docker-ephemeral-lvm.sh",
      "sudo systemctl stop redis",
      "sudo mkdir -p ${var.leaflet["data"]}/var/lib",
      "sudo mv /var/lib/redis ${var.leaflet["data"]}/var/lib/",
      "sudo ln -sf ${var.leaflet["data"]}/var/lib/redis /var/lib/redis",
      "sudo systemctl start redis",
      "sudo bash -c \"echo ${lookup(var.leaflet, "data_dev_mount", var.leaflet["data_dev"])} ${var.leaflet["data"]} auto defaults,nofail,comment=terraform 0 2 >> /etc/fstab\"",
      # provision displacement-ts-server
#      "cd /home/ops/verdi/ops",
#      "git clone https://github.com/hysds/displacement-ts-server.git -b dev",
#      "cd /home/ops/verdi/ops/displacement-ts-server",
#      "sudo pip install -r requirements.txt",
#      "cd configs/certs",
#      "openssl genrsa -des3 -passout pass:${var.pass_phrase} -out server.key 1024",
#      "OPENSSL_CONF=server.cnf openssl req -passin pass:${var.pass_phrase} -new -key server.key -out server.csr",
#      "cp server.key server.key.org",
#      "openssl rsa -passin pass:${var.pass_phrase} -in server.key.org -out server.key",
#      "chmod 600 server.key*",
#      "openssl x509 -req -days 99999 -in server.csr -signkey server.key -out server.crt",
#      "cd ../..",
#      "cp -rf /home/ops/verdi/ops/displacement-ts-server/verdi_configs/* /home/ops/verdi/etc/",
#      "docker build --rm --force-rm -t hysds/displacement-ts-server:latest .",
#      "sudo /usr/sbin/apachectl stop",
#      "supervisord -c /home/ops/verdi/etc/supervisord.conf"
#      "docker-compose up -d"
    ]
  }
}

output "leaflet_pvt_ip" {
  value = "${aws_instance.leaflet.private_ip}"
}

output "leaflet_pub_ip" {
  value = "${aws_instance.leaflet.public_ip}"
}


######################
# Mozart Provisioning
######################
resource "null_resource" "mozart" {

  connection {
    type     = "ssh"
    host = var.mozart_pvt_ip
    user     = "ops"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      # Add config file to .sds
      "cd /home/ops/.sds",
      "(echo 'VERDI_PVT_IP: ${aws_instance.leaflet.private_ip}'; echo 'TS_PVT_IP: ${aws_instance.leaflet.private_ip}') > tss_config",
      # provision displacement-ts-server
      "cd /home/ops/mozart/ops",
      "git clone https://github.com/hysds/displacement-ts-server.git -b dev",
      "cd /home/ops/mozart/ops/displacement-ts-server",
      "sudo pip install -r requirements.txt",
      "cd configs/certs",
      "openssl genrsa -des3 -passout pass:${var.pass_phrase} -out server.key 1024",
      "OPENSSL_CONF=server.cnf openssl req -passin pass:${var.pass_phrase} -new -key server.key -out server.csr",
      "cp server.key server.key.org",
      "openssl rsa -passin pass:${var.pass_phrase} -in server.key.org -out server.key",
      "chmod 600 server.key*",
      "openssl x509 -req -days 99999 -in server.csr -signkey server.key -out server.crt",
      "cd /home/ops/mozart/ops/displacement-ts-server/update_tss",
      "bash update_tss.sh"
    ]
  }
}


#resource "null_resource" "leaflet_server" {

#  connection {
#    type     = "ssh"
#    host = aws_instance.leaflet.private_ip
#    user     = "ops"
#    private_key = "${file(var.private_key_file)}"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#   ]
#  }