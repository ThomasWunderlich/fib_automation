variable "region" {
  type = string
  description = "The AWS region to place this in"
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
  description = "The CIDR to allocate for the VPC. When peering multiple VPCs together avoid overlapping CIDRs"
  default = "10.0.0.0/16"
}
