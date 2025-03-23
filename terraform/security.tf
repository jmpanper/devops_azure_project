resource "azurerm_network_security_group" "nsg" {
	name = "jmppcp2_rg"
	location = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name


	security_rule {
		name = "jmppcp2_ssh_sr"
		priority = 1001
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "22"
		source_address_prefix = "*"
		destination_address_prefix = "*"
	}

	security_rule {
		name = "jmppcp2_http_sr"
		priority = 1002
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "80"
		source_address_prefix = "*"
		destination_address_prefix = "*"
  	}
}
resource "azurerm_network_inteface_security_group_association"
"nicnsga" {
	network_interface_id 		= azurerm_network_interface.nic.id
	network_security_group_id 	= azurerm_network_security_group.nsg.id
}