#####################################################################################################################
# Terraform Template to install a Single ASAv in a AZ using BYOL AMI with Mgmt + Three Interfaces in a New VPC
#####################################################################################################################

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

data "template_file" "startup_file" {
  template = file("asa_startup_file.txt")
  vars = {
    enable_password = var.enable_password
  }
}

data "aws_availability_zones" "available" {}

#########################################################################################################################
# providers
#########################################################################################################################

provider "aws" {
  region = var.region
}


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

resource "aws_subnet" "mgmt_subnet" {
  count             = var.availability_zone_count
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.mgmt_subnet
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge({
    Name = var.vpc_name
  }, var.tags)

}

resource "aws_subnet" "outside_subnet" {
  count             = var.availability_zone_count
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.outside_subnet
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge({
    Name = "outside subnet"
  }, var.tags)

}

resource "aws_subnet" "inside_subnet" {
  count             = var.availability_zone_count
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.inside_subnet
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge({
    Name = "inside subnet"
  }, var.tags)
}

resource "aws_subnet" "dmz_subnet" {
  count             = var.availability_zone_count
  vpc_id            = aws_vpc.asa_vpc.id
  cidr_block        = var.dmz_subnet
  availability_zone = data.aws_availability_zones.available.names[count.index]
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
resource "aws_network_interface" "ASA_mgmt" {
  description       = "asa-mgmt"
  count             = var.availability_zone_count * var.instances_per_az
  subnet_id         = aws_subnet.mgmt_subnet[floor(count.index / var.instances_per_az)].id
  private_ips       = [var.asa_mgmt_ip]
  source_dest_check = false
}

resource "aws_network_interface" "ASA_outside" {
  description       = "asa-outside"
  count             = var.availability_zone_count * var.instances_per_az
  subnet_id         = aws_subnet.outside_subnet[floor(count.index / var.instances_per_az)].id
  private_ips       = [var.asa_outside_ip]
  source_dest_check = false
}

resource "aws_network_interface" "ASA_inside" {
  description       = "asa-inside"
  count             = var.availability_zone_count * var.instances_per_az
  subnet_id         = aws_subnet.inside_subnet[floor(count.index / var.instances_per_az)].id
  private_ips       = [var.asa_inside_ip]
  source_dest_check = false
}

resource "aws_network_interface" "ASA_dmz" {
  description       = "asd-dmz"
  count             = var.availability_zone_count * var.instances_per_az
  subnet_id         = aws_subnet.dmz_subnet[floor(count.index / var.instances_per_az)].id
  private_ips       = [var.asa_dmz_ip]
  source_dest_check = false
}

resource "aws_network_interface_sg_attachment" "asa_mgmt_attachment" {
  count                = var.availability_zone_count * var.instances_per_az
  depends_on           = [aws_network_interface.ASA_mgmt]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.ASA_mgmt[count.index].id
}

resource "aws_network_interface_sg_attachment" "asa_outside_attachment" {
  count                = var.availability_zone_count * var.instances_per_az
  depends_on           = [aws_network_interface.ASA_outside]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.ASA_outside[count.index].id
}

resource "aws_network_interface_sg_attachment" "asa_inside_attachment" {
  count                = var.availability_zone_count * var.instances_per_az
  depends_on           = [aws_network_interface.ASA_inside]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.ASA_inside[count.index].id
}

resource "aws_network_interface_sg_attachment" "asa_dmz_attachment" {
  count                = var.availability_zone_count * var.instances_per_az
  depends_on           = [aws_network_interface.ASA_dmz]
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.ASA_dmz[count.index].id
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
resource "aws_route" "inside_default_route" {
  count                  = var.availability_zone_count * var.instances_per_az
  depends_on             = [aws_instance.asav]
  route_table_id         = aws_route_table.asa_inside_route.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.ASA_inside[count.index].id
}

//To define the default route for DMZ network thur ASA inside interface
resource "aws_route" "DMZ_default_route" {
  count                  = var.availability_zone_count * var.instances_per_az
  depends_on             = [aws_instance.asav]
  route_table_id         = aws_route_table.asa_dmz_route.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.ASA_dmz[count.index].id
}

resource "aws_route_table_association" "outside_association" {
  count          = var.availability_zone_count * var.instances_per_az
  subnet_id      = aws_subnet.outside_subnet[count.index].id
  route_table_id = aws_route_table.asa_outside_route.id
}

resource "aws_route_table_association" "mgmt_association" {
  count          = var.availability_zone_count * var.instances_per_az
  subnet_id      = aws_subnet.mgmt_subnet[count.index].id
  route_table_id = aws_route_table.asa_outside_route.id
}

resource "aws_route_table_association" "inside_association" {
  count          = var.availability_zone_count * var.instances_per_az
  subnet_id      = aws_subnet.inside_subnet[count.index].id
  route_table_id = aws_route_table.asa_inside_route.id
}

resource "aws_route_table_association" "dmz_association" {
  count          = var.availability_zone_count * var.instances_per_az
  subnet_id      = aws_subnet.dmz_subnet[count.index].id
  route_table_id = aws_route_table.asa_dmz_route.id
}
##################################################################################################################################
# AWS External IP address creation and associating it to the mgmt and outside interface.
##################################################################################################################################
//External ip address creation

resource "aws_eip" "asa_mgmt-EIP" {
  count      = var.availability_zone_count * var.instances_per_az
  vpc        = true
  depends_on = [aws_internet_gateway.int_gw]
  tags = merge({
    "Name" = "ASA Management IP"
  }, var.tags)
}

resource "aws_eip" "asa_outside-EIP" {
  count      = var.availability_zone_count * var.instances_per_az
  vpc        = true
  depends_on = [aws_internet_gateway.int_gw]
  tags = merge({
    "Name" = "ASA outside IP"
  }, var.tags)
}

resource "aws_eip_association" "asa-mgmt-ip-assocation" {
  count                = var.availability_zone_count * var.instances_per_az
  network_interface_id = aws_network_interface.ASA_mgmt[count.index].id
  allocation_id        = aws_eip.asa_mgmt-EIP[count.index].id
}
resource "aws_eip_association" "asa-outside-ip-association" {
  count                = var.availability_zone_count * var.instances_per_az
  network_interface_id = aws_network_interface.ASA_outside[count.index].id
  allocation_id        = aws_eip.asa_outside-EIP[count.index].id
}

##################################################################################################################################
# Create the Cisco NGFW Instances
##################################################################################################################################
resource "aws_instance" "asav" {
  count         = var.availability_zone_count * var.instances_per_az
  ami           = data.aws_ami.asav.id
  instance_type = var.size
  key_name      = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.ASA_mgmt[count.index].id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.ASA_outside[count.index].id
    device_index         = 1
  }

  network_interface {
    network_interface_id = aws_network_interface.ASA_inside[count.index].id
    device_index         = 2
  }

  network_interface {
    network_interface_id = aws_network_interface.ASA_dmz[count.index].id
    device_index         = 3
  }

  user_data = data.template_file.startup_file.rendered

  tags = merge({
    Name = "Cisco ASAv"
  }, var.tags)
}
