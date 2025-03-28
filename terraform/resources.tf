resource "azurerm_resource_group" "rg" {
	name = "jmppcp2_rg"
	location = var.location
}

resource "azurerm_linux_virtual_machine" "lvm" {
  name                = "jmppcp2_ubuntuserver_lvm"
  computer_name       = "jmppcp2-ubuntuserver" 
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.ssh_user
  network_interface_ids = [azurerm_network_interface.nic.id,]
  disable_password_authentication = true

  admin_ssh_key {
  	username          = var.ssh_user
  	public_key        = file("~/.ssh/id_rsa.pub")
  }
  
  os_disk {
  	caching             = "ReadWrite"
  	storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  	publisher         = "Canonical"
  	offer             = "0001-com-ubuntu-server-jammy"
    sku               = "22_04-lts"
  	version           = "latest"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "jmppcp2acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks"{
  name                = "jmppcp2_aks"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  dns_prefix          = "jmppcp2aks"

  default_node_pool {
    name        = "default"
    node_count  = 1
    vm_size     = var.aks_vm_size 
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "ra" {
  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
    role_definition_name    = "AcrPull"
    scope                   = azurerm_container_registry.acr.id
    skip_service_principal_aad_check = true 
}