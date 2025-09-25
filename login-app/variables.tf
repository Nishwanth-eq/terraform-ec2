variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "db_username" {}
variable "db_password" {}

variable "acm_cert_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
  default     = null
}
