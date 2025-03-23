variable "location" {
  type = string
  description = "Región de Azure donde se crea la infraestructura"
  default = "West Europe" 
}

variable "vm_size" {
  type = string
  description = "Tamaño de la VM"
  default = "Standard_D1_v2"
}

variable "aks_vm_size" {
  type = string
  description = "Tamaño del AKS"
  default = "Standard_D2_v2"
}

variable "public_key_path" {
  type = string
  description = "Ruta de clave publica para las instancias"
  default = "~/.ssh/id_rsa.pub" # o la ruta correspondiente
}

variable "ssh_user" {
  type = string
  description = "Usuario para ssh"
  default = "adminuser"
}

output "kube_config" {
  value = "azurerm_kubernetes_cluster.aks.kube_config_raw"
  description = "Fichero de configuracion para conectar al Cluster Kubernetes"
  sensitive = true
}

output "acr_admin_password" {
  value = azurerm_container_registry.acr.admin_password
  description = "ACR admin password to log in"
  seitive = true
}

output "vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
  description = "IP Publica de VM Linux"
}
