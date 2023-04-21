######################################################################################################################
# Variables
#####################################################################################################################

# variable "aws_access_key" {}
# variable "aws_secret_key" {}
# variable "key_name" {}
variable "region" {
  default = "us-east-1"
}

variable "ASA_version" {
  type    = string
  default = "asav9-15-1"
}

variable "vpc_name" {
  type    = string
  default = "Service-VPC"
}

//defining the VPC CIDR
variable "vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

// defining the subnets variables with the default value for Three Tier Architecure.

variable "mgmt_subnet" {
  type    = string
  default = "10.1.0.0/24"
}

variable "outside_subnet" {
  type    = string
  default = "10.1.5.0/24"
}

variable "dmz_subnet" {
  type    = string
  default = "10.1.4.0/24"
}

variable "inside_subnet" {
  type    = string
  default = "10.1.3.0/24"
}

variable "asa_mgmt_ip" {
  type    = string
  default = "10.1.0.10"
}

variable "asa_outside_ip" {
  type    = string
  default = "10.1.5.10"
}

variable "asa_inside_ip" {
  type    = string
  default = "10.1.3.10"
}

variable "asa_dmz_ip" {
  type    = string
  default = "10.1.4.10"
}


variable "size" {
  type    = string
  default = "c5.xlarge"
}

//  Existing SSH Key on the AWS
variable "key_name" {
  type    = string
  default = "NGFW-KP"
}

variable "availability_zone_count" {
  type    = number
  default = 1
}

variable "instances_per_az" {
  type    = number
  default = 1
}

variable "enable_password" {
  type    = string
  default = "P@ssw0rd!"
}
variable "tags" {
  description = "tags to map with resources ."
  type        = map(any)
  default = {
    env = "dev"
  }
}
