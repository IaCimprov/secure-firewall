#####################################################################################################################
# Terraform module to install a Single ASAv in a AZ using BYOL AMI with Mgmt + Three Interfaces in a New VPC
#####################################################################################################################


provider "aws" {
  region = var.region
}

#########################################################################################################################
# data
#########################################################################################################################

data "aws_ami" "asav" {
  most_recent = true // you can enable this if you want to deploy more
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["${var.ASA_version}*"]
  }



  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "asa_startup_file" {
  count    = var.instances_per_az * var.availability_zone_count
  template = file("asa_startup_file.txt")
}

data "aws_availability_zones" "available" {}

# #########################################################################################################################
# # providers
# #########################################################################################################################
#
# provider "aws" {
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
#   region     = var.region
# }

###########################################################################################################################
#VPC Resources
###########################################################################################################################

resource "aws_vpc" "asa_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"
  tags = merge({
    Name = var.vpc_name
  }, var.tags)
}

resource "aws_subnet" "mgmt01_subnet" {
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.mgmt01_subnet
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge({
    Name = "mgmt AZ1 subnet"
  }, var.tags)
}

resource "aws_subnet" "mgmt02_subnet" {
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.mgmt02_subnet
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge({
    Name = "mgmt AZ2 subnet"
  }, var.tags)
}


resource "aws_subnet" "outside01_subnet" {
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.outside01_subnet
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge({
    Name = "outside subnet"
  }, var.tags)
}

resource "aws_subnet" "outside02_subnet" {
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.outside02_subnet
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge({
    Name = "outside subnet"
  }, var.tags)
}

resource "aws_subnet" "inside01_subnet" {

  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.inside01_subnet
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge({
    Name = "inside subnet"
  }, var.tags)
}

resource "aws_subnet" "inside02_subnet" {

  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.inside02_subnet
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge({
    Name = "inside subnet"
  }, var.tags)
}

resource "aws_subnet" "dmz01_subnet" {

  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.dmz01_subnet
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge({
    Name = "dmz subnet"
  }, var.tags)
}

resource "aws_subnet" "dmz02_subnet" {

  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.dmz02_subnet
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge({
    Name = "dmz subnet"
  }, var.tags)
}

#################################################################################################################################
# Security Group
#################################################################################################################################

resource "aws_security_group" "allow_all" {
  name        = "Allow All"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.asa_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "Public Allow"
  }, var.tags)
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.asa_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge({
    Name = "Local Allow"
  }, var.tags)
}

##################################################################################################################################
# Network Interfaces, ASA instance, Attaching the SG to interfaces
##################################################################################################################################
resource "aws_network_interface" "asa01_mgmt" {
  description       = "asa01-mgmt"
  subnet_id         = aws_subnet.mgmt01_subnet.id
  source_dest_check = false
  private_ips       = [var.asa01_mgmt_ip]
  tags              = var.tags
}

resource "aws_network_interface" "asa02_mgmt" {
  description       = "asa02-mgmt"
  subnet_id         = aws_subnet.mgmt02_subnet.id
  source_dest_check = false
  private_ips       = [var.asa02_mgmt_ip]
  tags              = var.tags
}

resource "aws_network_interface" "asa01_outside" {

  description       = "asa01-outside"
  subnet_id         = aws_subnet.outside01_subnet.id
  source_dest_check = false
  private_ips       = [var.asa01_outside_ip]
  tags              = var.tags
}

resource "aws_network_interface" "asa02_outside" {

  description       = "asa02-outside"
  subnet_id         = aws_subnet.outside02_subnet.id
  source_dest_check = false
  private_ips       = [var.asa02_outside_ip]
  tags              = var.tags
}

resource "aws_network_interface" "asa01_inside" {

  description       = "asa01-inside"
  subnet_id         = aws_subnet.inside01_subnet.id
  source_dest_check = false
  private_ips       = [var.asa01_inside_ip]
  tags              = var.tags
}

resource "aws_network_interface" "asa02_inside" {

  description       = "asa02-inside"
  subnet_id         = aws_subnet.inside02_subnet.id
  source_dest_check = false
  private_ips       = [var.asa02_inside_ip]
  tags              = var.tags
}

resource "aws_network_interface" "asa01_dmz" {
  description       = "asa01-dmz"
  subnet_id         = aws_subnet.dmz01_subnet.id
  source_dest_check = false
  private_ips       = [var.asa01_dmz_ip]
  tags              = var.tags

}

resource "aws_network_interface" "asa02_dmz" {
  description       = "asa02-dmz"
  subnet_id         = aws_subnet.dmz02_subnet.id
  source_dest_check = false
  private_ips       = [var.asa02_dmz_ip]
  tags              = var.tags

}

resource "aws_network_interface_sg_attachment" "asa01_mgmt_attachment" {
  depends_on           = [aws_network_interface.asa01_mgmt]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa01_mgmt.id
}

resource "aws_network_interface_sg_attachment" "asa02_mgmt_attachment" {
  depends_on           = [aws_network_interface.asa02_mgmt]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa02_mgmt.id
}

resource "aws_network_interface_sg_attachment" "asa01_outside_attachment" {
  depends_on           = [aws_network_interface.asa01_outside]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa01_outside.id
}

resource "aws_network_interface_sg_attachment" "asa02_outside_attachment" {
  depends_on           = [aws_network_interface.asa02_outside]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa02_outside.id
}

resource "aws_network_interface_sg_attachment" "asa01_inside_attachment" {
  depends_on           = [aws_network_interface.asa01_inside]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa01_inside.id
}

resource "aws_network_interface_sg_attachment" "asa02_inside_attachment" {
  depends_on           = [aws_network_interface.asa02_inside]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa02_inside.id
}

resource "aws_network_interface_sg_attachment" "asa01_dmz_attachment" {
  depends_on           = [aws_network_interface.asa01_dmz]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa01_dmz.id
}

resource "aws_network_interface_sg_attachment" "asa02_dmz_attachment" {
  depends_on           = [aws_network_interface.asa02_dmz]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.asa02_dmz.id
}

##################################################################################################################################
#Internet Gateway and Routing Tables
##################################################################################################################################

//define the internet gateway
resource "aws_internet_gateway" "int_gw" {
  vpc_id = aws_vpc.asa_vpc.id
  tags = merge({
    Name = "Internet Gateway"
  }, var.tags)
}
//create the route table for outside, inside and DMZ
resource "aws_route_table" "asa_outside_route" {
  vpc_id = aws_vpc.asa_vpc.id
  tags = merge({
    Name = "outside network Routing table"
  }, var.tags)
}

resource "aws_route_table" "asa_inside_route" {
  vpc_id = aws_vpc.asa_vpc.id
  tags = merge({
    Name = "inside network Routing table"
  }, var.tags)
}

resource "aws_route_table" "asa_dmz_route" {
  vpc_id = aws_vpc.asa_vpc.id

  tags = merge({
    Name = "dmz network Routing table"
  }, var.tags)
}

//To define the default routes thru IGW
resource "aws_route" "ext_default_route" {
  route_table_id         = aws_route_table.asa_outside_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.int_gw.id
}

//To define the default route for inside network thur ASAv inside interface
#resource "aws_route" "inside_default_route" {
#  depends_on              = [aws_instance.asav01]
#  route_table_id          = aws_route_table.asa_inside_route.id
#  destination_cidr_block  = "0.0.0.0/0"
#  network_interface_id    = aws_network_interface.asa01_inside.id
#}

//To define the default route for DMZ network thur ASA DMZ interface
#resource "aws_route" "DMZ_default_route" {
#  depends_on              = [aws_instance.asav01]
#  route_table_id          = aws_route_table.asa_dmz_route.id
#  destination_cidr_block  = "0.0.0.0/0"
#  network_interface_id    = aws_network_interface.asa01_dmz.id
#}

resource "aws_route_table_association" "outside01_association" {
  subnet_id      = aws_subnet.outside01_subnet.id
  route_table_id = aws_route_table.asa_outside_route.id
}

resource "aws_route_table_association" "outside02_association" {
  subnet_id      = aws_subnet.outside02_subnet.id
  route_table_id = aws_route_table.asa_outside_route.id
}

resource "aws_route_table_association" "mgmt01_association" {
  subnet_id      = aws_subnet.mgmt01_subnet.id
  route_table_id = aws_route_table.asa_outside_route.id
}

resource "aws_route_table_association" "mgmt02_association" {
  subnet_id      = aws_subnet.mgmt02_subnet.id
  route_table_id = aws_route_table.asa_outside_route.id
}

resource "aws_route_table_association" "inside01_association" {
  subnet_id      = aws_subnet.inside01_subnet.id
  route_table_id = aws_route_table.asa_inside_route.id
}

resource "aws_route_table_association" "inside02_association" {
  subnet_id      = aws_subnet.inside02_subnet.id
  route_table_id = aws_route_table.asa_inside_route.id
}

resource "aws_route_table_association" "dmz01_association" {
  subnet_id      = aws_subnet.dmz01_subnet.id
  route_table_id = aws_route_table.asa_dmz_route.id
}

resource "aws_route_table_association" "dmz02_association" {
  subnet_id      = aws_subnet.dmz02_subnet.id
  route_table_id = aws_route_table.asa_dmz_route.id
}

##################################################################################################################################
# AWS External IP address creation and associating it to the mgmt and outside interface.
##################################################################################################################################
//External ip address creation
resource "aws_eip" "asa01_mgmt-EIP" {
  vpc        = true
  depends_on = [aws_internet_gateway.int_gw]
  tags = merge({
    "Name" = "asa01 Management IP"
  }, var.tags)
}

resource "aws_eip" "asa02_mgmt-EIP" {
  vpc        = true
  depends_on = [aws_internet_gateway.int_gw]
  tags = merge({
    "Name" = "asa02 Management IP"
  }, var.tags)

}


resource "aws_eip" "asa01_outside-EIP" {
  vpc        = true
  depends_on = [aws_internet_gateway.int_gw]
  tags = merge({
    "Name" = "asa01 outside IP"
  }, var.tags)
}

resource "aws_eip" "asa02_outside-EIP" {
  vpc        = true
  depends_on = [aws_internet_gateway.int_gw]
  tags = merge({
    "Name" = "asa02 outside IP"
  }, var.tags)
}

resource "aws_eip_association" "asa01-mgmt-ip-assocation" {
  network_interface_id = aws_network_interface.asa01_mgmt.id
  allocation_id        = aws_eip.asa01_mgmt-EIP.id
}

resource "aws_eip_association" "asa02-mgmt-ip-assocation" {
  network_interface_id = aws_network_interface.asa02_mgmt.id
  allocation_id        = aws_eip.asa02_mgmt-EIP.id
}

resource "aws_eip_association" "asa01-outside-ip-association" {
  network_interface_id = aws_network_interface.asa01_outside.id
  allocation_id        = aws_eip.asa01_outside-EIP.id
}

resource "aws_eip_association" "asa02-outside-ip-association" {
  network_interface_id = aws_network_interface.asa02_outside.id
  allocation_id        = aws_eip.asa02_outside-EIP.id
}

##################################################################################################################################
# Create the Cisco ASA01 Instances (First Instance)
##################################################################################################################################

resource "aws_instance" "asav01" {
  ami           = data.aws_ami.asav.id
  instance_type = var.asa_size
  key_name      = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.asa01_mgmt.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.asa01_outside.id
    device_index         = 1
  }

  network_interface {
    network_interface_id = aws_network_interface.asa01_inside.id
    device_index         = 2
  }

  network_interface {
    network_interface_id = aws_network_interface.asa01_dmz.id
    device_index         = 3
  }

  user_data = data.template_file.asa_startup_file[1].rendered

  tags = merge({
    Name = "Cisco asav01"
  }, var.tags)
}

##################################################################################################################################
# Create the Cisco ASA02 Instances (Secound Instance)
##################################################################################################################################

resource "aws_instance" "asav02" {
  ami           = data.aws_ami.asav.id
  instance_type = var.asa_size
  key_name      = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.asa02_mgmt.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.asa02_outside.id
    device_index         = 1
  }

  network_interface {
    network_interface_id = aws_network_interface.asa02_inside.id
    device_index         = 2
  }

  network_interface {
    network_interface_id = aws_network_interface.asa02_dmz.id
    device_index         = 3
  }

  user_data = data.template_file.asa_startup_file[0].rendered

  tags = merge({
    Name = "Cisco asav02"
  }, var.tags)
}
#########################################################################################################
# Creation of Load Balancer
#########################################################################################################

resource "aws_lb" "external01-lb" {

  name                             = "External01-LB"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = "true"
  tags                             = var.tags

  subnet_mapping {
    subnet_id = aws_subnet.outside01_subnet.id

  }
  subnet_mapping {
    subnet_id = aws_subnet.outside02_subnet.id

  }
}

resource "aws_lb" "external02-lb" {
  name                             = "External02-LB"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = "true"
  tags                             = var.tags


  subnet_mapping {
    subnet_id = aws_subnet.outside02_subnet.id

  }
  subnet_mapping {
    subnet_id = aws_subnet.outside01_subnet.id

  }
}

resource "aws_lb" "internal01-lb" {
  name                             = "Inside01-LB"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = "true"
  tags                             = var.tags


  subnet_mapping {
    subnet_id = aws_subnet.inside01_subnet.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.inside02_subnet.id
  }
}


resource "aws_lb" "internal02-lb" {
  name                             = "Inside02-LB"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = "true"
  tags                             = var.tags



  subnet_mapping {
    subnet_id = aws_subnet.inside01_subnet.id
  }
  subnet_mapping {
    subnet_id = aws_subnet.inside02_subnet.id
  }
}


resource "aws_lb_listener" "listener1-1" {
  load_balancer_arn = aws_lb.external01-lb.arn
  for_each          = var.listener_ports
  port              = each.key
  protocol          = each.value
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end1-1[each.key].arn
  }
}

resource "aws_lb_listener" "listener1-2" {
  load_balancer_arn = aws_lb.external02-lb.arn
  for_each          = var.listener_ports
  port              = each.key
  protocol          = each.value
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end1-2[each.key].arn
  }
}

#####################################################################
//optional  -- Only required when you want to use Internal LB.
######################################################################
resource "aws_lb_listener" "listener2-1" {
  #  count             = var.internal_lb_enable == "true" ? 1 : 0
  load_balancer_arn = aws_lb.internal01-lb.arn
  for_each          = var.listener_ports
  port              = each.key
  protocol          = each.value
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end2-1[each.key].arn
  }
}

resource "aws_lb_listener" "listener2-2" {
  #  count             = var.internal_lb_enable == "true" ? 1 : 0
  load_balancer_arn = aws_lb.internal02-lb.arn
  for_each          = var.listener_ports
  port              = each.key
  protocol          = each.value
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end2-2[each.key].arn
  }
}


resource "aws_lb_target_group" "front_end1-1" {
  for_each    = var.listener_ports
  name        = tostring("fe1-1-${each.key}")
  port        = each.key
  protocol    = each.value
  target_type = "ip"
  vpc_id      = aws_vpc.asa_vpc.id
  tags        = var.tags


  health_check {
    interval = 30
    protocol = var.health_check.protocol
    port     = var.health_check.port
  }

}

resource "aws_lb_target_group" "front_end1-2" {
  for_each    = var.listener_ports
  name        = tostring("fe1-2-${each.key}")
  port        = each.key
  protocol    = each.value
  target_type = "ip"
  vpc_id      = aws_vpc.asa_vpc.id
  tags        = var.tags


  health_check {
    interval = 30
    protocol = var.health_check.protocol
    port     = var.health_check.port
  }
}

#####################################################################
//optional  -- Only required when you want to use Internal LB.
######################################################################
resource "aws_lb_target_group" "front_end2-1" {
  # count = var.internal_lb_enable == "true" ? 1 : 0
  for_each    = var.listener_ports
  name        = tostring("fe2-1-${each.key}")
  port        = each.key
  protocol    = each.value
  target_type = "ip"
  vpc_id      = aws_vpc.asa_vpc.id

  health_check {
    interval = 30
    protocol = var.health_check.protocol
    port     = var.health_check.port
  }
}

resource "aws_lb_target_group" "front_end2-2" {
  # count = var.internal_lb_enable == "true" ? 1 : 0
  for_each    = var.listener_ports
  name        = tostring("fe2-2-${each.key}")
  port        = each.key
  protocol    = each.value
  target_type = "ip"
  vpc_id      = aws_vpc.asa_vpc.id

  health_check {
    interval = 30
    protocol = var.health_check.protocol
    port     = var.health_check.port
  }
}

resource "aws_lb_target_group_attachment" "target1_1a" {
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end1-1]
  target_group_arn = aws_lb_target_group.front_end1-1[each.key].arn
  target_id        = var.asa01_outside_ip
}

resource "aws_lb_target_group_attachment" "target1_1b" {
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end1-2]
  target_group_arn = aws_lb_target_group.front_end1-2[each.key].arn
  target_id        = var.asa01_outside_ip
}

resource "aws_lb_target_group_attachment" "target1_2a" {
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end1-1]
  target_group_arn = aws_lb_target_group.front_end1-1[each.key].arn
  target_id        = var.asa02_outside_ip
}

resource "aws_lb_target_group_attachment" "target1_2b" {
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end1-2]
  target_group_arn = aws_lb_target_group.front_end1-2[each.key].arn
  target_id        = var.asa02_outside_ip
}
#####################################################################
//optional  -- Only required to map the target group to Internal LB.
######################################################################
resource "aws_lb_target_group_attachment" "target2_1a" {
  #  count = var.internal_lb_enable == "true" ? 1 : 0
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end2-1]
  target_group_arn = aws_lb_target_group.front_end2-1[each.key].arn
  target_id        = var.asa01_inside_ip
}

resource "aws_lb_target_group_attachment" "target2_1b" {
  #  count = var.internal_lb_enable == "true" ? 1 : 0
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end2-2]
  target_group_arn = aws_lb_target_group.front_end2-2[each.key].arn
  target_id        = var.asa01_inside_ip
}

//optional
resource "aws_lb_target_group_attachment" "target2_2a" {
  #  count = var.internal_lb_enable == "true" ? 1 : 0
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end2-1]
  target_group_arn = aws_lb_target_group.front_end2-1[each.key].arn
  target_id        = var.asa02_inside_ip
}

resource "aws_lb_target_group_attachment" "target2_2b" {
  #  count = var.internal_lb_enable == "true" ? 1 : 0
  for_each         = var.listener_ports
  depends_on       = [aws_lb_target_group.front_end2-2]
  target_group_arn = aws_lb_target_group.front_end2-2[each.key].arn
  target_id        = var.asa02_inside_ip
}
