output "public_ip_address" {
  description = "Deployment target for Ansible."
  value       = azurerm_public_ip.public_ip.ip_address
}
output "admin_username" {
  description = "SSH username used by deployment automation."
  value       = var.admin_username
}
output "application_url" {
  description = "HTTP demo URL; no TLS is configured."
  value       = "http://${azurerm_public_ip.public_ip.ip_address}"
}
