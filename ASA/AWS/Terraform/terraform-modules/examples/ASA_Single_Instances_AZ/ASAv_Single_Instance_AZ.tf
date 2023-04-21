#####################################################################################################################
# Terraform Template to install a Single ASAv in a AZ using BYOL AMI with Mgmt + Three Interfaces in a New VPC
#####################################################################################################################
#########################################################################################################################
# providers
#########################################################################################################################

# provider "aws" {
#   version    = ">= 3.27.0"
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
#   region     = var.region
# }
terraform {
  backend "local" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.27.0"
    }
  }

}


################################################################################################################################
# Resource Group Creation using module
################################################################################################################################

module "asa-aws" {
  source = "../../modules/ASA_Single_Instances_AZ"
  // If you dont provide any value, it will take the default value
  ############################################################
  #AWS Creditials to access the AWS Cloud
  #############################################################
  # aws_access_key = ""
  #
  # aws_secret_key = ""

  ###########################################################
  #Define New VPC in a specific Region and Avilability Zone
  #############################################################
  // Tags to map with resources
  tags = {
    env = "prod"
  }

  vpc_name = "Transit-Service-VPC1"

  region = "ap-south-1"

  ##################################################################################
  #Define CIDR, Subnets for managment and three for Inside, Outisde and DMZ
  ###################################################################################
  vpc_cidr = "10.1.0.0/16"

  mgmt_subnet = "10.1.0.0/24"

  outside_subnet = "10.1.1.0/24"

  inside_subnet = "10.1.2.0/24"

  dmz_subnet = "10.1.3.0/24"

  key_name = "lx1"
  # Generate the key if you want to login thru the  key

  ###########################################################################################
  #Define the Instance size of ASA and attach the interfaces and Day0 Configuration
  ###########################################################################################
  //ASA Interfaces IP address Configurations
  //Download the ASA_startup_file and manage the Configurations
  //Please refer ASAv datasheet for the supported "size"
  //https://www.cisco.com/c/en/us/products/collateral/security/adaptive-security-virtual-appliance-asav/datasheet-c78-733399.html?dtid=osscdc000283
  #Remove the # before using it

  size = "c5.xlarge"

  ASA_version = "asav9-19-1"
  //Allowed Values = asav9-15-1, asav9-14-1-30, asav9-12-4-4, asav9-14-1-10, asav9-13-1-12

  asa_mgmt_ip = "10.1.0.10"

  asa_outside_ip = "10.1.1.10"

  asa_inside_ip = "10.1.2.10"

  asa_dmz_ip = "10.1.3.10"

  enable_password = "P@ssw0rd!"

}
