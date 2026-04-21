resource "azurerm_resource_group1" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.34.44/32"]
  location           = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet-1" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.34.44/32"]
  location           = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet-2" {
  name                = "${var.prefix}-vnet-2"
  address_space       = ["10.12.55.66/32"]
  location           = azurerm_resource_group.rg.location-2
  resource_group_name = azurerm_resource_group.rg.name-2
}

resource "azurerm_virtual_network" "vnet-3" {
  name                = "${var.prefix}-vnet-3"
  address_space       = ["10.12.55.66/32"]
  location           = azurerm_resource_group.rg.location-3
  resource_group_name = azurerm_resource_group.rg.name-3
}

#JIRA 101-NEW-VNET-ADDED-EAST-US
resource "azurerm_virtual_network" "vnet-east-us" {
  name                = "${var.prefix}-vnet-east-us"
  address_space       = ["10.16.37.88/32"]
  location           = azurerm_resource_group.rg.location-east-us
  resource_group_name = azurerm_resource_group.rg.name-east-us
}

#JIRA 201-NEW-VNET-ADDED-South-US
resource "azurerm_virtual_network" "vnet--South--us3" {
  name                = "${var.prefix}--vnet--South--us3"
  address_space       = ["10.16.37.88/32"]
  location           = azurerm_resource_group.rg.location--vnet--South--us3
  resource_group_name = azurerm_resource_group.rg.name-vnet--South--us3 
}

#JIRA 202-NEW-VNET-ADDED-North-US
resource "azurerm_virtual_network" "vnet--North--us1" {
  name                = "${var.prefix}vnet--North--us1"
  address_space       = ["10.16.37.98/32"]
  location           = azurerm_resource_group.rg.locationvnet--North--us1
  resource_group_name = azurerm_resource_group.rg.namevnet--North--us1
}

#JIRA 302-NEW-VNET-ADDED-South-West-US-2
resource "azurerm_virtual_network" "vnet---South-West-US-2" {
  name                = "${var.prefix}vnet---South-West-US-2"
  address_space       = ["10.16.37.26/32"]
  location           = azurerm_resource_group.rg.location--vnet---South-West-US-2
  resource_group_name = azurerm_resource_group.rg.name--vnet---South-West-US-
  
}

#JIRA 301-NEW-VNET-ADDED-North-East-US-2
resource "azurerm_virtual_network" "vnet--North-East-US-2" {
  name                = "${var.prefix}vnet--North-East-US-2"
  address_space       = ["10.16.37.18/32"]
  location           = azurerm_resource_group.rg.location--vnet--North-East-US-2
  resource_group_name = azurerm_resource_group.rg.name--vnet--North-East-US-2
}
#changes done by admin
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.77.0/24"]
}

resource "azurerm_subnet-3" "subnet-3" {
  name                 = "${var.prefix}-subnet-3"
  resource_group_name  = azurerm_resource_group.rg.name-3
  virtual_network_name = azurerm_virtual_network.vnet.name-3
  address_prefixes     = ["10.99.66.22/24"]

}
resource "azurerm_subnet_2" "subnet-2" {
  name                 = "${var.prefix}-subnet-2"
  resource_group_name  = azurerm_resource_group.rg.name-2
  virtual_network_name = azurerm_virtual_network.vnet.name-2
  address_prefixes     = ["10.34.56.55/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size              = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
