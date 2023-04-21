# ASAv single instances in a AZ

## Prerequisite

* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
* aws v3.27.0 (signed by HashiCorp)
* aws hashicorp/template v2.2.0


## Overview

Using this Terraform template, a single instance ASA can be deployed in a new VPC with the following components: 

- one new VPC with 4 subnets
- Availability Zone
- Two network security groups (one default and other one is created to allow all traffic)

*Note*: It is important to change the security group to allow only the traffic from and to the specific IP address and port. 

- Routing table attachment to these subnets 
- EIP attachment to the Management and Outside subnet. 

The following parameters should be configured in the "terraform.tfvars" file before using the templates. 
*Please note the value provided below is just an example. Please change it based on your requirements.*  

Specify your access key and secret key credentials 


## AWS Credentials to access the AWS Cloud

aws_access_key      = ""

aws_secret_key      = ""
  
## Define New VPC in a specific Region and Availability Zone 

vpc_name            = "Transit-Service-VPC"

region               = "ap-south-1"


## Define CIDR, Subnets for managment and three for Inside, Outside and DMZ

vpc_cidr           = "10.1.0.0/16"

mgmt_subnet        = "10.1.0.0/24"

outside_subnet     = "10.1.1.0/24"

inside_subnet      = "10.1.2.0/24"

dmz_subnet         = "10.1.3.0/24" 

key_name             = ""  --> .pem key file should be generated before



## Define the Instance size of ASA and attach the interfaces and day0 configuration

ASA Interfaces IP address Configurations 
Download the ASA_startup_file and update the configurations 

Please refer the below ASAv datasheet for the supported "size" 
https://www.cisco.com/c/en/us/products/collateral/security/adaptive-security-virtual-appliance-asav/datasheet-c78-733399.html?dtid=osscdc000283

size                = "c5.xlarge"

ASA_version         = "asav9-15-1-1"
//Allowed Values = asav9-15-1, asav9-14-1-30, asav9-12-4-4, asav9-14-1-10, asav9-13-1-12

asa_mgmt_ip       =     "10.1.0.10"

asa_outside_ip    =     "10.1.1.10"  

asa_inside_ip     =     "10.1.2.10"       

asa_dmz_ip        =     "10.1.3.10"

## Deployment Procedure

1) Clone or Download the Repository 
2) Customize the variables in the terraform.tfvars and variables.tf (only to change the default value)
3) Initialize the providers and modules
     - go to the specific terraform folder from the cli 
        $ cd xxxx
        $ terraform init 
 4) Submit the terraform plan 
       $ terraform plan -out <filename>
 5) Verify the output of the plan in the terminal, if everything is fine then apply the plan 
        $ terraform apply <out filename generated earlier>
 6) If output is fine, configure it by typing "yes"
 7) Once if executed, it will show you the IP addresss of the management interface configured. Use this to access the ASA

Note: Please don't delete or modify the file with the extension ".tfstate" file. This file maintained the current deployment status and used while modifying any parameters or while destroying this setup. 

## To Destroy the setup and ASAv instance created through terraform. 
To destroy the instance, use the command:
     $ terraform destroy 
 
 # Disclaimer 
 <TBD>
 

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_eip.asa_mgmt-EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.asa_outside-EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.asa-mgmt-ip-assocation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_eip_association.asa-outside-ip-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.asav](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.int_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_network_interface.ASA_dmz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.ASA_inside](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.ASA_mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.ASA_outside](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface_sg_attachment.asa_dmz_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa_inside_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa_mgmt_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa_outside_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_route.DMZ_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.ext_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.inside_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.asa_dmz_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.asa_inside_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.asa_outside_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.dmz_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.inside_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.mgmt_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.outside_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.dmz_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.inside_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.mgmt_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.outside_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.asa_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ami.asav](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [template_file.startup_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ASA_version"></a> [ASA\_version](#input\_ASA\_version) | n/a | `string` | `"asav9-15-1"` | no |
| <a name="input_asa_dmz_ip"></a> [asa\_dmz\_ip](#input\_asa\_dmz\_ip) | n/a | `string` | `"10.1.4.10"` | no |
| <a name="input_asa_inside_ip"></a> [asa\_inside\_ip](#input\_asa\_inside\_ip) | n/a | `string` | `"10.1.3.10"` | no |
| <a name="input_asa_mgmt_ip"></a> [asa\_mgmt\_ip](#input\_asa\_mgmt\_ip) | n/a | `string` | `"10.1.0.10"` | no |
| <a name="input_asa_outside_ip"></a> [asa\_outside\_ip](#input\_asa\_outside\_ip) | n/a | `string` | `"10.1.5.10"` | no |
| <a name="input_availability_zone_count"></a> [availability\_zone\_count](#input\_availability\_zone\_count) | n/a | `number` | `1` | no |
| <a name="input_dmz_subnet"></a> [dmz\_subnet](#input\_dmz\_subnet) | n/a | `string` | `"10.1.4.0/24"` | no |
| <a name="input_enable_password"></a> [enable\_password](#input\_enable\_password) | n/a | `string` | `"P@ssw0rd!"` | no |
| <a name="input_inside_subnet"></a> [inside\_subnet](#input\_inside\_subnet) | n/a | `string` | `"10.1.3.0/24"` | no |
| <a name="input_instances_per_az"></a> [instances\_per\_az](#input\_instances\_per\_az) | n/a | `number` | `1` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Existing SSH Key on the AWS | `string` | `"NGFW-KP"` | no |
| <a name="input_mgmt_subnet"></a> [mgmt\_subnet](#input\_mgmt\_subnet) | n/a | `string` | `"10.1.0.0/24"` | no |
| <a name="input_outside_subnet"></a> [outside\_subnet](#input\_outside\_subnet) | n/a | `string` | `"10.1.5.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | variable "aws\_access\_key" {} variable "aws\_secret\_key" {} variable "key\_name" {} | `string` | `"us-east-1"` | no |
| <a name="input_size"></a> [size](#input\_size) | n/a | `string` | `"c5.xlarge"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to map with resources . | `map(any)` | <pre>{<br>  "env": "dev"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | defining the VPC CIDR | `string` | `"10.1.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"Service-VPC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip"></a> [ip](#output\_ip) | ################################################################################################################################# Output ################################################################################################################################# |
<!-- END_TF_DOCS -->