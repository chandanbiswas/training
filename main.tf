#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-7e50c21a
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-cobra
#


variable "num_webs" {
   default = "3"
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
   type = "string"
   default = "us-west-1"
}


provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count = "${var.num_webs}"
  ami           = "ami-30217250"
  instance_type = "t2.micro"
  subnet_id     = "subnet-7e50c21a"

  vpc_security_group_ids = ["sg-29ef374e"]

  tags {
    Identity = "autodesk-cobra"
    name = "web ${count.index+1}/${var.num_webs}"
    zip = "94539"
  }
}

output "public_ip" {
   value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
   value = ["${aws_instance.web.*.public_dns}"]
}

output "name" {
   value = "${aws_instance.web.tags.name}"
}





