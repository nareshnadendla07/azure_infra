########################################
### Azure Winodws Virtual Machine Module
#########################################

resource "azurerm_windows_virtual_machine" "win_vm" {
  count                                                  = var.os_flavor == "windows" ? var.instances_count : 0
  name                                                   = var.instances_count == 1 ? substr(var.virtual_machine_name, 0, 20) : substr(format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1), 0, 20)
  computer_name                                          = var.instances_count == 1 ? substr(replace(var.virtual_machine_name, "-", ""), 0, 15) : substr(format("%s%s", lower(replace(replace(var.virtual_machine_name, "-", ""), "/[[:^alnum:]]/", "")), count.index + 1), 0, 15)
  location                                               = var.location
  resource_group_name                                    = var.resource_group_name
  size                                                   = var.virtual_machine_size
  admin_username                                         = var.admin_username
  admin_password                                         = var.admin_password
  source_image_id                                        = var.source_image_id != null ? var.source_image_id : null
  provision_vm_agent                                     = true
  allow_extension_operations                             = true
  dedicated_host_id                                      = var.dedicated_host_id
  custom_data                                            = var.custom_data != null ? var.custom_data : null
  enable_automatic_updates                               = var.enable_automatic_updates
  license_type                                           = var.license_type
  availability_set_id                                    = var.availability_set_id #? azurerm_availability_set.aset[0].id : null
  encryption_at_host_enabled                             = var.enable_encryption_at_host
  proximity_placement_group_id                           = var.proximity_placement_group_id #? azurerm_proximity_placement_group.appgrp[0].id : null
  patch_mode                                             = var.patch_mode
  zone                                                   = var.vm_availability_zone
  timezone                                               = var.vm_time_zone
  network_interface_ids                                  = [var.network_interface_id]
  priority                                               = var.use_spot_instance ? "Spot" : "Regular"
  eviction_policy                                        = var.use_spot_instance ? var.eviction_policy : null
  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
  patch_assessment_mode                                  = var.patch_assessment_mode
  tags                                                   = merge({ "ResourceName" = var.instances_count == 1 ? var.virtual_machine_name : format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1) }, var.tags)



  os_disk {
    name                      = var.os_disk.name
    caching                   = var.os_disk.caching
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
    storage_account_type      = var.os_disk_storage_account_type
    disk_size_gb              = var.os_disk.disk_size_gb
    disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id != null ? [] : [1]
    content {
      publisher = var.custom_image != null ? var.custom_image["publisher"] : var.windows_distribution_list[var.windows_distribution_name]["publisher"]
      offer     = var.custom_image != null ? var.custom_image["offer"] : var.windows_distribution_list[var.windows_distribution_name]["offer"]
      sku       = var.custom_image != null ? var.custom_image["sku"] : var.windows_distribution_list[var.windows_distribution_name]["sku"]
      version   = var.custom_image != null ? var.custom_image["version"] : var.windows_distribution_list[var.windows_distribution_name]["version"]
    }
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

  dynamic "winrm_listener" {
    for_each = var.winrm_protocol != null ? [1] : []
    content {
      protocol        = var.winrm_protocol
      certificate_url = var.winrm_protocol == "Https" ? var.key_vault_certificate_secret_url : null
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_content != null ? [1] : []
    content {
      content = var.additional_unattend_content
      setting = var.additional_unattend_content_setting
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
      patch_mode,
    ]
  }
}
