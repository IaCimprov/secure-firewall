# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.65.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # subscription_id = "..."
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}

# Create a resource group
module "fmc-azure" {
  source                           = "../modules/fmc-azure"
  virtual_machine_admin_username   = "cisco"
  virtual_machine_admin_passw      = "tqtqtug1452@@"
  virtual_machine_fmcv_admin_passw = "123Cisco@1"
  // Tags to map with resources
  tags = {
    env = "prod"
  }
  # resource_group_name              = "FMC_RG"
  # resource_group_location          = "East US"
  # virtual_network_name             = "vnetprod01"
  # subnet_name_1                    = "subnet01"
  # subnet_name_2                    = "subnet02"
  # subnet_name_3                    = "subnet03"
  # subnet_name_4                    = "subnet04"
  # public_ip_win                    = "publicip02"
  # public_ip_ubuntu                 = "publicip01"
  # public_ip_fmc                    = "publicfmcip01"
  # network_security_group_VM        = "nsgprod01"
  # network_security_group_ALL       = "fmcprod01"
  # network_interface_win            = "nicwin01"
  # network_interface_name           = "nicprod01"
  # network_interface_fmc            = "fmcmgmt"
  # linux_virtual_machine_name       = "linuxvm01"
  # fmc_virtual_machine_name         = "fmcv01"
  # win_virtual_machine_name         = "win10JUMP"
  # fmc_version                      = "73069.0.0"
}
