# 📦 Azure AVD Session Host Registration Module

This Terraform module deploys the `azurerm_virtual_machine_extension` to register one or more virtual machines as session hosts in an Azure Virtual Desktop (AVD) Host Pool using PowerShell DSC.

## 🔧 Usage

```hcl
module "register_avd" {
  source                    = "./modules/register_avd"
  instances_count           = 2
  virtual_machine_ids       = [azurerm_windows_virtual_machine.vm1.id, azurerm_windows_virtual_machine.vm2.id]
  host_pool_name            = "MyHostPool"
  registration_token        = "your_registration_token_here"
  modules_url               = "file:///C:/installers/Configuration.zip"
}
```

## 📌 Input Variables

| Name                      | Type          | Description                                                  | Default                      |
|---------------------------|---------------|--------------------------------------------------------------|------------------------------|
| `instances_count`         | `number`      | Number of VM extensions to create                            | n/a                          |
| `virtual_machine_ids`     | `list(string)`| List of VM IDs                                                | n/a                          |
| `extension_name_prefix`   | `string`      | Prefix for the extension name                                | `SessionHostForWindows`      |
| `publisher`               | `string`      | Publisher of the extension                                   | `Microsoft.Powershell`       |
| `type`                    | `string`      | Type of the extension                                        | `DSC`                        |
| `type_handler_version`    | `string`      | Version of the extension handler                             | `2.73`                       |
| `auto_upgrade_minor_version` | `bool`    | Enable auto-upgrade for minor version                        | `true`                       |
| `modules_url`             | `string`      | URL or path to the DSC `.zip` file                           | n/a                          |
| `configuration_function`  | `string`      | Configuration function in the DSC script                     | `Configuration.ps1\AddSessionHost` |
| `host_pool_name`          | `string`      | AVD Host Pool name                                           | n/a                          |
| `registration_token`      | `string`      | Registration token for session host registration             | n/a                          |

## 📤 Output

This module does not output any values.

## 🔐 Security

Make sure to **securely handle** the `registration_token` value and avoid committing it into version control.

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
