
################################################################################################
### Network variables
################################################################################################

variable "rg_name" {
  type        = string
  description = "Azure Resource Group"
  default     = ""
}

variable "location" {
  description = "Geographic region resource will be deployed into"
  type        = string
  default     = ""
}

variable "create_vn" {
  default     = true
  type        = string
  description = "Wheather to create Virtual Network"
}

variable "vn_name" {
  type        = string
  default     = ""
  description = "Existing Virtual Network Name"
}

variable "vn_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Virtual Network CIDR"
}


variable "subnet_size" {
  type        = string
  default     = 24
  description = "Size of Subnets"
}

variable "source_address" {
  type        = string
  default     = "*"
  description = "Limit the Management access to specific source"
}

variable "instances" {
  type        = number
  description = "Number of FTDv instances"
}

variable "create_fmc" {
  type        = bool
  default     = true
  description = "Create fmc or not"
}

variable "azs" {
  type        = list
  default = [
    "1",
    "2",
    "3"
  ]
  description = "Azure Availability Zones"
}

variable "prefix" {
  type        = string
  default     = "cisco-FTDv"
  description = "Prefix to prepend resource names"
}

variable "subnets" {
  default     = []
  description = "subnets for FTD interfaces"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "Dev"
  }
}

variable "fmc_prefix" {
  type        = string
  default     = "cisco-FMCv"
  description = "Prefix to prepend ot FMC resource names"
}


variable "network_interface_fmc" {
  type        = string
  default     = "network_interface_fmc"
  description = "FMC Virtual Network Iinterface Name"
}
