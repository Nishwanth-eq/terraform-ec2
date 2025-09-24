provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "nishwanth" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = var.key_name
}