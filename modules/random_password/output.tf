output "password" {
  description = "The generated random password"
  value       = random_password.password.result
}
