variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
}

variable "instance_type" {
  description = "The type of instance to use"
}

variable "subnet_id" {
  description = "The subnet ID where the instance will be launched"
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"  
}
