module "container-server" {
  source = "../.."

  domain = "app.${var.domain}"
  email  = var.email

  container = {
    image = "quay.io/keycloak/keycloak:latest"
  }
}

resource "azurerm_resource_group" "app" {
  name     = var.base_resource_name
  location = var.location
}

resource "azurerm_linux_virtual_machine" "app" {
  name                            = var.base_resource_name
  resource_group_name             = azurerm_resource_group.app.name
  location                        = azurerm_resource_group.app.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.app.id,
  ]

  os_disk {
    name                 = "${var.base_resource_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "30"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name = var.base_resource_name
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}
