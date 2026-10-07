variable "project_name" {
  description = "Azure resource name prefix."
  type        = string
  default     = "devops-demo"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,30}$", var.project_name))
    error_message = "Use 3-31 lowercase letters, digits or hyphens, starting with a letter."
  }
}
variable "location" {
  description = "Azure deployment region."
  type        = string
  default     = "eastus"
}
variable "vm_size" {
  description = "VM size; availability depends on region and subscription."
  type        = string
  default     = "Standard_B1s"
}
variable "admin_username" {
  description = "Linux SSH administrator."
  type        = string
  default     = "azureuser"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_-]{0,30}$", var.admin_username)) && var.admin_username != "root"
    error_message = "Use a valid non-root Linux username."
  }
}
variable "ssh_public_key" {
  description = "Public SSH key text; pass through TF_VAR_ssh_public_key."
  type        = string
  validation {
    condition     = can(regex("^ssh-(rsa|ed25519) ", trimspace(var.ssh_public_key)))
    error_message = "Provide an OpenSSH RSA or Ed25519 public key."
  }
}
variable "ssh_allowed_cidr" {
  description = "Operator or Jenkins egress IPv4 CIDR permitted over SSH."
  type        = string
  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr)) && try(tonumber(split("/", var.ssh_allowed_cidr)[1]) >= 24, false)
    error_message = "Provide an IPv4 CIDR with prefix /24 or narrower; prefer your egress IP /32."
  }
}
