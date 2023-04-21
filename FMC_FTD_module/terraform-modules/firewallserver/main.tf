################################################################################################################################
# FTDv Instance Creation
################################################################################################################################

resource "azurerm_virtual_machine" "ftdv-instance" {
  name                = "${var.prefix}-vm%{if var.instances > 1}-${count.index}%{endif}"
  count               = var.instances
  location            = var.location
  resource_group_name = var.rg_name

  primary_network_interface_id = element(var.ftdv-interface-management, count.index)
  network_interface_ids = [element(var.ftdv-interface-management, count.index),
    element(var.ftdv-interface-diagnostic, count.index),
    element(var.ftdv-interface-outside, count.index),
    element(var.ftdv-interface-inside, count.index)
  ]
  vm_size = var.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  plan {
    name      = "ftdv-azure-byol"
    publisher = "cisco"
    product   = "cisco-ftdv"
  }

  storage_image_reference {
    publisher = "cisco"
    offer     = "cisco-ftdv"
    sku       = "ftdv-azure-byol"
    version   = var.image_version
  }
  storage_os_disk {
    name              = "${var.prefix}-myosdisk%{if var.instances > 1}-${count.index}%{endif}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.instancename}%{if var.instances > 1}${count.index}%{endif}"
    admin_username = var.username
    admin_password = var.password
    custom_data = templatefile(
      "${path.module}/ftd_startup_file.txt", {
        fmc_ip   = var.fmc_public_ip,
        password = var.password,
        hostname = "${var.instancename}%{if var.instances > 1}${count.index}%{endif}"
      }
    )
  }
  os_profile_linux_config {
    disable_password_authentication = false

  }
  zones = var.instances == 1 ? [] : [local.az_distribution[count.index]]
  tags = merge({
    Name = "FTDv"
  }, var.tags)
}



resource "azurerm_virtual_machine" "fmcv" {
  count = var.create_fmc ? 1 : 0
  name  = "${var.fmc_prefix}-vm"
  #  name                  = var.fmc_virtual_machine_name
  location                     = var.location
  resource_group_name          = var.rg_name
  primary_network_interface_id = var.fmcv-interface-management
  network_interface_ids = [var.fmcv-interface-management,
    element(var.ftdv-interface-diagnostic, count.index),
    element(var.ftdv-interface-outside, count.index),
    element(var.ftdv-interface-inside, count.index)
  ]

  vm_size = "Standard_D4_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  plan {
    name      = "fmcv-azure-byol"
    product   = "cisco-fmcv"
    publisher = "cisco"
  }

  storage_image_reference {
    publisher = "cisco"
    offer     = "cisco-fmcv"
    sku       = "fmcv-azure-byol"
    version   = var.fmc_image_version
  }

  storage_os_disk {
    name              = "${var.fmc_prefix}-myosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }



  #####################
  os_profile {
    computer_name  = var.fmc_instancename
    admin_username = var.username
    admin_password = var.password
    custom_data = templatefile(
      "${path.module}/fmc_startup_file.txt", {
        password = var.password,
        hostname = var.fmc_instancename
      }
    )
  }

  os_profile_linux_config {
    disable_password_authentication = false
    ######################
    # computer_name                   = "fmcv-01"
    # admin_username                  = var.virtual_machine_admin_username
    # admin_password                  = var.virtual_machine_fmcv_admin_passw
    # disable_password_authentication = false
    # custom_data                     = base64encode(data.template_file.startup_file_fmc.rendered)
    #
    # admin_ssh_key {
    #   username   = var.virtual_machine_admin_username
    #   public_key = file("~/.ssh/id_rsa.pub")
  }

  tags = merge({
    Name = "FMCv"
  }, var.tags)
}
