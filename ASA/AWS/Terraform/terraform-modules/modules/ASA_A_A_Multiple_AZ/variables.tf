#####################################################################################################################
# Variables
#####################################################################################################################

# variable "aws_access_key" {}
# variable "aws_secret_key" {}
# variable "key_name" {}
variable "region" {
  type    = string
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
  default = "10.0.0.0/16"
}

// defining the subnets variables with the default value for Three Tier Architecure.

variable "mgmt01_subnet" {
  type    = string
  default = "10.0.1.0/24"
}

variable "mgmt02_subnet" {
  type    = string
  default = "10.0.10.0/24"
}

variable "asa01_mgmt_ip" {
  type    = string
  default = "10.0.1.10"
}

variable "asa02_mgmt_ip" {
  type    = string
  default = "10.0.10.20"
}

variable "outside01_subnet" {
  type    = string
  default = "10.0.5.0/24"
}

variable "outside02_subnet" {
  type    = string
  default = "10.0.50.0/24"
}

variable "asa01_outside_ip" {
  type    = string
  default = "10.0.5.10"
}

variable "asa02_outside_ip" {
  type    = string
  default = "10.0.50.20"
}

variable "dmz01_subnet" {
  type    = string
  default = "10.0.4.0/24"
}

variable "dmz02_subnet" {
  type    = string
  default = "10.0.40.0/24"
}

variable "asa01_dmz_ip" {
  type    = string
  default = "10.0.4.10"
}

variable "asa02_dmz_ip" {
  type    = string
  default = "10.0.40.20"
}

variable "inside01_subnet" {
  type    = string
  default = "10.0.3.0/24"
}

variable "inside02_subnet" {
  type    = string
  default = "10.0.30.0/24"
}

variable "asa01_inside_ip" {
  type    = string
  default = "10.0.3.10"
}

variable "asa02_inside_ip" {
  type    = string
  default = "10.0.30.20"
}

variable "asa_size" {
  default = "c5.2xlarge"
}

//  Existing SSH Key on the AWS
variable "key_name" {
  type    = string
  default = "NGFW-KP"

}

variable "availability_zone_count" {
  type    = number
  default = 2
}

variable "instances_per_az" {
  type    = number
  default = 2
}

variable "listener_ports" {
  default = {
    22 = "TCP"
    #443 = "TCP"
  }
}

variable "health_check" {
  default = {
    protocol = "TCP"
    port     = 22
  }
}

variable "internal_lb_enable" {
  type    = bool
  default = "false"
}

variable "tags" {
  description = "tags to map with resources ."
  type        = map(any)
  default = {
    env = "dev"
  }
}
