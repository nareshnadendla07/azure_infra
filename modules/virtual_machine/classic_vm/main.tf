#############################################
# Construct the Linux & Windows configuration
#############################################
locals {
  linux_configuration = {
    disable_password_authentication = var.disable_password_authentication
    ssh = {
      public_keys = var.public_keys
    }
    provision_vm_agent = var.provision_vm_agent
  }

  windows_configuration = {
    provision_vm_agent       = var.provision_vm_agent
    enable_automatic_updates = var.enable_automatic_updates
    time_zone                = var.time_zone != "" ? var.time_zone : null
    winrm = length(var.win_rm) > 0 ? {
      listeners = var.win_rm
    } : null
  }
}

#############################
## Create the Virtual Machine
#############################

resource "azurerm_virtual_machine" "vm" {
  name                = var.vm_name
  vm_size             = var.vm_size
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  storage_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }


  storage_os_disk {
    name              = var.os_disk.name
    caching           = var.os_disk.caching
    create_option     = var.os_disk.create_option
    managed_disk_type = var.os_disk.managed_disk_type
    disk_size_gb      = var.os_disk.disk_size_gb
  }

  dynamic "storage_data_disk" {
    for_each = var.data_disks
    content {
      lun               = storage_data_disk.value.lun
      name              = storage_data_disk.value.name
      caching           = storage_data_disk.value.caching
      create_option     = storage_data_disk.value.create_option
      managed_disk_type = storage_data_disk.value.managed_disk_type
      disk_size_gb      = storage_data_disk.value.disk_size_gb
    }
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password

  }

  dynamic "os_profile_linux_config" {
    for_each = var.os_type == "Linux" ? [1] : []
    content {
      disable_password_authentication = local.linux_configuration.disable_password_authentication

    }
  }

  dynamic "os_profile_windows_config" {
    for_each = var.os_type == "Windows" ? [1] : []
    content {
      provision_vm_agent = local.windows_configuration.provision_vm_agent


      dynamic "winrm" {
        for_each = var.win_rm
        content {
          protocol = winrm.value.protocol
        }
      }
    }
  }

  network_interface_ids = [var.network_interface_id]
  
}
