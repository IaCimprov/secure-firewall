# ASAv multiple instances in a single AZ

## Prerequisite

* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >=v1.0.1 
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

key_name             = ""  --> .pem key file should be generated before (Before running terraform apply, generate an EC2 key pair that can be used to SSH into EC2 instances. You can do this manually using the AWS Console or the AWS CLI (aws ec2 create-key-pair --key-name <key_name> ). After that inset name of key to module variable)



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
2) Customize the variables (only to change the default value)
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

## Requirements


| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.27.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asa-aws"></a> [asa-aws](#module\_asa-aws) | ../../modules/ASA_A_A_Single_AZ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_eip.asa01_mgmt-EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.asa01_outside-EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.asa02_mgmt-EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.asa02_outside-EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.asa01-mgmt-ip-assocation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_eip_association.asa01-outside-ip-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_eip_association.asa02-mgmt-ip-assocation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_eip_association.asa02-outside-ip-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.asav01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.asav02](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.int_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lb.external-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.internal-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.listener1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.listener2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.front_end1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.front_end2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.target1_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target1_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target2_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target2_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_network_interface.asa01_dmz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.asa01_inside](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.asa01_mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.asa01_outside](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.asa02_dmz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.asa02_inside](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.asa02_mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.asa02_outside](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface_sg_attachment.asa01_dmz_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa01_inside_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa01_mgmt_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa01_outside_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa02_dmz_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa02_inside_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa02_mgmt_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_network_interface_sg_attachment.asa02_outside_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_sg_attachment) | resource |
| [aws_route.ext_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
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
| [template_file.asa_startup_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ASA_version"></a> [ASA\_version](#input\_ASA\_version) | n/a | `string` | `"asav9-15-1"` | no |
| <a name="input_asa01_dmz_ip"></a> [asa01\_dmz\_ip](#input\_asa01\_dmz\_ip) | n/a | `string` | `"10.0.4.10"` | no |
| <a name="input_asa01_inside_ip"></a> [asa01\_inside\_ip](#input\_asa01\_inside\_ip) | n/a | `string` | `"10.0.3.10"` | no |
| <a name="input_asa01_mgmt_ip"></a> [asa01\_mgmt\_ip](#input\_asa01\_mgmt\_ip) | n/a | `string` | `"10.0.1.10"` | no |
| <a name="input_asa01_outside_ip"></a> [asa01\_outside\_ip](#input\_asa01\_outside\_ip) | n/a | `string` | `"10.0.5.10"` | no |
| <a name="input_asa02_dmz_ip"></a> [asa02\_dmz\_ip](#input\_asa02\_dmz\_ip) | n/a | `string` | `"10.0.4.20"` | no |
| <a name="input_asa02_inside_ip"></a> [asa02\_inside\_ip](#input\_asa02\_inside\_ip) | n/a | `string` | `"10.0.3.20"` | no |
| <a name="input_asa02_mgmt_ip"></a> [asa02\_mgmt\_ip](#input\_asa02\_mgmt\_ip) | n/a | `string` | `"10.0.1.20"` | no |
| <a name="input_asa02_outside_ip"></a> [asa02\_outside\_ip](#input\_asa02\_outside\_ip) | n/a | `string` | `"10.0.5.20"` | no |
| <a name="input_asa_size"></a> [asa\_size](#input\_asa\_size) | n/a | `string` | `"c5.2xlarge"` | no |
| <a name="input_availability_zone_count"></a> [availability\_zone\_count](#input\_availability\_zone\_count) | n/a | `number` | `1` | no |
| <a name="input_dmz_subnet"></a> [dmz\_subnet](#input\_dmz\_subnet) | n/a | `string` | `"10.0.4.0/24"` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | `map` | <pre>{<br>  "port": 22,<br>  "protocol": "TCP"<br>}</pre> | no |
| <a name="input_inside_subnet"></a> [inside\_subnet](#input\_inside\_subnet) | n/a | `string` | `"10.0.3.0/24"` | no |
| <a name="input_instances_per_az"></a> [instances\_per\_az](#input\_instances\_per\_az) | n/a | `number` | `2` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Existing SSH Key on the AWS | `string` | n/a | yes |
| <a name="input_listener_ports"></a> [listener\_ports](#input\_listener\_ports) | n/a | `map` | <pre>{<br>  "22": "TCP"<br>}</pre> | no |
| <a name="input_mgmt_subnet"></a> [mgmt\_subnet](#input\_mgmt\_subnet) | n/a | `string` | `"10.0.1.0/24"` | no |
| <a name="input_outside_subnet"></a> [outside\_subnet](#input\_outside\_subnet) | n/a | `string` | `"10.0.5.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | variable "aws\_access\_key" {} variable "aws\_secret\_key" {} variable "key\_name" {} | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to map with resources . | `map(any)` | <pre>{<br>  "env": "dev"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | defining the VPC CIDR | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"Service-VPC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asa01ip"></a> [asa01ip](#output\_asa01ip) | n/a |
| <a name="output_asa02ip"></a> [asa02ip](#output\_asa02ip) | n/a |
<!-- END_TF_DOCS -->