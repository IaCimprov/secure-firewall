#--------------------------Resource Group--------------------------------#
module "rg" {
  source   = "../../terraform-modules/rg"
  rg_name  = var.rg_name
  location = var.location
}

#--------------------------Network--------------------------------#
module "network" {
  source     = "../../terraform-modules/network"
  rg_name    = module.rg.resource_group_name[0]
  location   = module.rg.location[0]
  create_fmc = var.create_fmc
  instances  = var.instances
  depends_on = [module.rg]
}

# # #--------------------------Firewall--------------------------------#
module "server" {
  source                    = "../../terraform-modules/firewallserver"
  rg_name                   = module.rg.resource_group_name[0]
  location                  = module.rg.location[0]
  create_fmc                = var.create_fmc
  instances                 = var.instances
  ftdv-interface-management = [module.network.mgmt_interface[0]]
  ftdv-interface-diagnostic = [module.network.diag_interface[0]]
  ftdv-interface-outside    = [module.network.outside_interface[0]]
  ftdv-interface-inside     = [module.network.inside_interface[0]]
  # ftdv-interface-management = [module.network.mgmt_interface[0], module.network.mgmt_interface[1]]
  # ftdv-interface-diagnostic = [module.network.diag_interface[0], module.network.diag_interface[1]]
  # ftdv-interface-outside    = [module.network.outside_interface[0], module.network.outside_interface[1]]
  # ftdv-interface-inside     = [module.network.inside_interface[0], module.network.inside_interface[1]]
  fmcv-interface-management = module.network.fmcv-interface-management
  fmc_public_ip             = module.network.fmc_public_ip
  depends_on                = [module.rg, module.network]
}
