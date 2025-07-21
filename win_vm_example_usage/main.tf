
module "nuix_vm_nic" {
  source              = "../../modules/network/network-interface"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  count               = 4

  nic_name                      = format("%s-nic-%02d", var.nuix_vm_name, count.index + 1)
  subnet_id                     = data.azurerm_subnet.nuix_snet.id
  private_ip_allocation_method  = var.private_ip_allocation_method
  private_ip_address            = ""
  public_ip_address_id          = ""
  enable_accelerated_networking = var.enable_accelerated_networking
  enable_ip_forwarding          = var.enable_ip_forwarding
  primary                       = var.primary

  tags = var.tags

  #depends_on = [module.vnet]
}

######################
## Create Forensic ASG
######################

module "nuix_asg" {
  source               = "../../modules/network/application-security-group"
  name                 = var.nuix_asg_name
  count                = 1
  location             = var.location
  resource_group_name  = var.resource_group_name
  network_interface_id = module.nuix_vm_nic[count.index].nic_id

  tags       = var.tags
  depends_on = [module.nuix_vm_nic]
}


################################
## FRC Disk Encryption
################################

module "nuix_disk_encryption_set" {
  source                       = "../../modules/disk_encryption"
  count                        = 4
  disk_encryption_set_name     = format("%s-des-%02d", var.nuix_vm_name, count.index + 1)
  vm_name                      = format("%s-%02d", var.nuix_vm_name, count.index + 1)
  location                     = var.location
  resource_group_name          = data.azurerm_resource_group.rg.name
  auto_key_rotation_enabled    = true
  identity_ids                 = [data.azurerm_user_assigned_identity.example.id]
  disk_encryption_principal_id = data.azurerm_user_assigned_identity.example.principal_id

  key_vault_key_id = data.azurerm_key_vault_key.example.versionless_id
  key_vault_id     = data.azurerm_key_vault.example.id
  tags             = var.tags
  #depends_on       = [module.key_vault]
}

########################
## mwd Windows Server VM 
########################

module "nuix_vm" {

  source = "../../modules/virtual-machine/windows"

  # Resource Group, location, VNet and Subnet details
  resource_group_name = var.resource_group_name
  location            = var.location
  count               = 4

  virtual_machine_name      = format("%s-%02d", var.nuix_vm_name, count.index + 1)
  os_flavor                 = "windows"
  windows_distribution_name = "windows2022dc"
  virtual_machine_size      = var.nuix_vm_size
  admin_username            = var.win_admin_username
  admin_password            = data.azurerm_key_vault_secret.example["nuix-vm01-pass-PowerAdmin"].value
  #instances_count           = 2

  proximity_placement_group_id    = data.azurerm_proximity_placement_group.example.id
  availability_set_id             = data.azurerm_availability_set.example.id
  disable_password_authentication = var.disable_password_authentication
  enable_automatic_updates        = var.enable_automatic_updates
  network_interface_id            = module.nuix_vm_nic[count.index].nic_id

  source_image_id = "/subscriptions/2a167c2c-4fe7-45db-b90c-c6a1fafdd9dd/resourceGroups/ep-p-nuixws-images-rg/providers/Microsoft.Compute/galleries/eppnuixwsimages/images/ep-p-nuixws-images-2022-base-img/versions/2025.01.02"
  # old image :"/subscriptions/2a167c2c-4fe7-45db-b90c-c6a1fafdd9dd/resourceGroups/ep-p-nuixws-images-rg/providers/Microsoft.Compute/galleries/eppnuixwsimages/images/ep-p-nuixws-images-2022-base-img/versions/2024.11.21"
  image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  os_disk = {
    name                             = format("%s-os-disk-%02d", var.nuix_vm_name, count.index + 1)
    caching                          = "ReadWrite"
    create_option                    = "FromImage"
    managed_disk_type                = "Standard_LRS"
    disk_size_gb                     = 150
    enable_os_disk_write_accelerator = false
    os_disk_storage_account_type     = "Standard_LRS"
    disk_encryption_set_id           = module.nuix_disk_encryption_set[count.index].disk_encryption_set_id
  }

  data_disks = []



  enable_boot_diagnostics = true
  #custom_data                  = base64encode(templatefile("./user_data.ps1", { admin_password = module.random_password_win_vm.password }))
  deploy_log_analytics_agent   = true
  boot_diagnostics_storage_uri = ""


  tags       = var.tags
  depends_on = [module.nuix_disk_encryption_set]

}
