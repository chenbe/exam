# Local Values
locals {
  vpc_name                 = "py-vnet"
  public_subnet_name       = "py-public-subnet"
  internet_gateway_name    = "py-internet-gateway"
  public_route_table_name  = "py-public-route-table"
  alb_security_group_name  = "py-alb-security-group"
  asg_security_group_name  = "py-asg-security-group"
}

variable "aws_region" {
  description = "AWS region name"
  type        = string
  default     = "us-east-1"
  }

# VPC Variables
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string   
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet cidr block"
  type          = string
  default = "10.0.1.0/24"
}

variable "az_names" {
  type          = string
  default = "us-east-1a"
}

variable "ami" {
  description = "ami id"
  type        = string
  default     = "ami-05c13eab67c5d8861"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.xlarge"    # "t2.micro"
}

