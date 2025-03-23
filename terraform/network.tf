resource "azurerm_virtual_network" "vn" {
	name = "jmppcp2_vn"
	location = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name
	address_space = ["10.0.0.0.0/16"]
}

resource "azurerm_subnet" "sn" {
	name = "jmppcp2_sn"
	resource_group_name = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.vn.name
	address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
	name = "jmppcp2_nic"
	location = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name

		ip_configuration {
		name = "jmmppcp2_ipconf"
		subnet_id = azurerm_subnet.sn.id
		private_ip_address_allocation = "Static"
		public_ip_address = "10.0.1.10"
		public_ip_address_id = azurerm_public_ip.pip.id
	}
}

resource "azurerm_public_ip" "pip" {
	name = "jmppcp2_pip"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	allocatiion_nethod = "Dynamic"
	sku = "Basic"
}