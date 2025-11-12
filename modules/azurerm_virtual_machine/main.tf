resource "azurerm_network_interface" "vmnic" {
  name                = var.nicname
  location            = var.niclocation
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.pipid
  }
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  name                  = var.vmname
  location              = var.vmlocation
  resource_group_name   = var.resource_group_name
  size                  = var.vmsize
  admin_username        = var.vmusername
  admin_password        = var.vmpassword
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.vmnic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.disktype
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

}

