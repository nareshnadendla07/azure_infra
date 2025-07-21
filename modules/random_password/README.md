
# 🔐 Random Password Module

This Terraform module creates a secure random password using the `random_password` resource.

## 📦 Resources

- `random_password`: Generates a random password with specified length, special characters, and override options.

## 📥 Input Variables

| Name              | Type    | Description                                              | Required |
|-------------------|---------|----------------------------------------------------------|----------|
| `length`          | number  | The desired length of the password.                      | Yes      |
| `special`         | bool    | Include special characters in the result string.         | Yes      |
| `override_special`| string  | Supply custom set of special characters.                 | Yes      |

## 📤 Output Variables

None by default. You can expose the password using an output if needed (ensure it is protected).

## ✅ Example Usage

```hcl
module "random_password" {
  source           = "./modules/random_password"
  length           = 20
  special          = true
  override_special = "!@#$%&*()-_=+"
}
```

## ⚠️ Security & Compliance

- **Avoid printing the password to console output or logs.**
- **Do not expose the password as a plain-text output in production environments.**
- Make sure to use the generated password only in secure storage (e.g., Key Vault, Secrets Manager).


## 📚 Resources

- [Terraform Random Provider Docs](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)


## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!