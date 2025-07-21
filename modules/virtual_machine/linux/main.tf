################################################################
# Generates SSH2 key Pair for Linux VM's (Dev Environment only)
###############################################################
resource "tls_private_key" "rsa" {
  count     = var.generate_admin_ssh_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

#######################
# Linux Virutal machine
#######################

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                           = var.os_flavor == "linux" ? var.instances_count : 0
  name                            = var.instances_count == 1 ? substr(var.virtual_machine_name, 0, 64) : substr(format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1), 0, 64)
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.virtual_machine_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids           = [var.network_interface_id]
  source_image_id                 = var.source_image_id != null ? var.source_image_id : null
  provision_vm_agent              = true
  allow_extension_operations      = true
  dedicated_host_id               = var.dedicated_host_id
  custom_data                     = var.custom_data != null ? var.custom_data : null
  availability_set_id             = var.availability_set_id #? azurerm_availability_set.aset[0].id : null
  encryption_at_host_enabled      = var.enable_encryption_at_host
  proximity_placement_group_id    = var.proximity_placement_group_id #? azurerm_proximity_placement_group.appgrp[0].id : null
  zone                            = var.vm_availability_zone
  tags                            = merge({ "ResourceName" = var.instances_count == 1 ? var.virtual_machine_name : format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1) }, var.tags, )

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication && var.generate_admin_ssh_key ? [1] : []
    content {
      username   = var.admin_username
      public_key = tls_private_key.rsa[0].public_key_openssh
    }
  }

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  os_disk {
    name                      = var.os_disk.name
    caching                   = var.os_disk.caching
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
    storage_account_type      = var.os_disk_storage_account_type
    disk_size_gb              = var.os_disk.disk_size_gb
    disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
  }

  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
