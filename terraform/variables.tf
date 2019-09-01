variable "aws_region" {
  description = "Region for the VPC"
  default = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.1.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.1.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "CIDR for the public subnet"
  default = "10.1.2.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-0975ce566eec139c3"
}
