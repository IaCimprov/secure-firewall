

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
| [aws_lb.external01-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.external02-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.internal01-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.internal02-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.listener1-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.listener1-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.listener2-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.listener2-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.front_end1-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.front_end1-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.front_end2-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.front_end2-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.target1_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target1_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target1_2a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target1_2b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target2_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target2_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target2_2a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.target2_2b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
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
| [aws_route_table_association.dmz01_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.dmz02_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.inside01_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.inside02_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.mgmt01_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.mgmt02_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.outside01_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.outside02_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.dmz01_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.dmz02_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.inside01_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.inside02_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.mgmt01_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.mgmt02_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.outside01_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.outside02_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
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
| <a name="input_asa02_dmz_ip"></a> [asa02\_dmz\_ip](#input\_asa02\_dmz\_ip) | n/a | `string` | `"10.0.40.20"` | no |
| <a name="input_asa02_inside_ip"></a> [asa02\_inside\_ip](#input\_asa02\_inside\_ip) | n/a | `string` | `"10.0.30.20"` | no |
| <a name="input_asa02_mgmt_ip"></a> [asa02\_mgmt\_ip](#input\_asa02\_mgmt\_ip) | n/a | `string` | `"10.0.10.20"` | no |
| <a name="input_asa02_outside_ip"></a> [asa02\_outside\_ip](#input\_asa02\_outside\_ip) | n/a | `string` | `"10.0.50.20"` | no |
| <a name="input_asa_size"></a> [asa\_size](#input\_asa\_size) | n/a | `string` | `"c5.2xlarge"` | no |
| <a name="input_availability_zone_count"></a> [availability\_zone\_count](#input\_availability\_zone\_count) | n/a | `number` | `2` | no |
| <a name="input_dmz01_subnet"></a> [dmz01\_subnet](#input\_dmz01\_subnet) | n/a | `string` | `"10.0.4.0/24"` | no |
| <a name="input_dmz02_subnet"></a> [dmz02\_subnet](#input\_dmz02\_subnet) | n/a | `string` | `"10.0.40.0/24"` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | `map` | <pre>{<br>  "port": 22,<br>  "protocol": "TCP"<br>}</pre> | no |
| <a name="input_inside01_subnet"></a> [inside01\_subnet](#input\_inside01\_subnet) | n/a | `string` | `"10.0.3.0/24"` | no |
| <a name="input_inside02_subnet"></a> [inside02\_subnet](#input\_inside02\_subnet) | n/a | `string` | `"10.0.30.0/24"` | no |
| <a name="input_instances_per_az"></a> [instances\_per\_az](#input\_instances\_per\_az) | n/a | `number` | `2` | no |
| <a name="input_internal_lb_enable"></a> [internal\_lb\_enable](#input\_internal\_lb\_enable) | n/a | `bool` | `"false"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Existing SSH Key on the AWS | `string` | `"NGFW-KP"` | no |
| <a name="input_listener_ports"></a> [listener\_ports](#input\_listener\_ports) | n/a | `map` | <pre>{<br>  "22": "TCP"<br>}</pre> | no |
| <a name="input_mgmt01_subnet"></a> [mgmt01\_subnet](#input\_mgmt01\_subnet) | n/a | `string` | `"10.0.1.0/24"` | no |
| <a name="input_mgmt02_subnet"></a> [mgmt02\_subnet](#input\_mgmt02\_subnet) | n/a | `string` | `"10.0.10.0/24"` | no |
| <a name="input_outside01_subnet"></a> [outside01\_subnet](#input\_outside01\_subnet) | n/a | `string` | `"10.0.5.0/24"` | no |
| <a name="input_outside02_subnet"></a> [outside02\_subnet](#input\_outside02\_subnet) | n/a | `string` | `"10.0.50.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | variable "aws\_access\_key" {} variable "aws\_secret\_key" {} variable "key\_name" {} | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to map with resources . | `map(any)` | <pre>{<br>  "env": "dev"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | defining the VPC CIDR | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"Service-VPC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asa01ip"></a> [asa01ip](#output\_asa01ip) | ################################################################################################################################# Output ################################################################################################################################# |
| <a name="output_asa02ip"></a> [asa02ip](#output\_asa02ip) | n/a |
<!-- END_TF_DOCS -->