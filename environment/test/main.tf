# module "resource_group" {
#   source                  = "../../modules/azurerm_resource_group"
#   resource_group_name     = "rgasad"
#   resource_group_location = "centralindia"
# }

# module "virtual_network" {
#   depends_on               = [module.resource_group]
#   source                   = "../../modules/azurerm_virtual_network"
#   virtual_network_name     = "vnetasad"
#   virtual_network_location = "centralindia"
#   resource_group_name      = "rgasad"
# }

# module "frontend-subnet" {
#   depends_on           = [module.virtual_network]
#   source               = "../../modules/azurerm_subnet"
#   subnet_name          = "frontendsubnetasad"
#   resource_group_name  = "rgasad"
#   virtual_network_name = "vnetasad"
#   address_prefixes     = ["10.0.1.0/24"]
# }

# module "frontendvm" {
#   depends_on          = [module.frontend-subnet, data.azurerm_key_vault_secret.vm_username_data, data.azurerm_key_vault_secret.vm_password_data]
#   source              = "../../modules/azurerm_virtual_machine"
#   vmname              = "frontendvmasad"
#   vmlocation          = "centralindia"
#   resource_group_name = "rgasad"
#   vmsize              = "Standard_B1s"
#   vmusername          = data.azurerm_key_vault_secret.vm_username_data.value
#   vmpassword          = data.azurerm_key_vault_secret.vm_password_data.value

#   disktype = "Standard_LRS"

#   image_publisher = "Canonical"
#   image_offer     = "0001-com-ubuntu-server-jammy"
#   image_sku       = "22_04-lts"

#   nicname     = "nicasad"
#   niclocation = "centralindia"
#   subnet_id   = data.azurerm_subnet.frontend-subnet-data.id
#   pipid       = data.azurerm_public_ip.pip_data.id
# }

# data "azurerm_subnet" "frontend-subnet-data" {
#   depends_on           = [module.frontend-subnet]
#   name                 = "frontendsubnetasad"
#   virtual_network_name = "vnetasad"
#   resource_group_name  = "rgasad"
# }

# module "public_IP" {
#   depends_on          = [module.resource_group]
#   source              = "../../modules/azurerm_public_ip"
#   pip_name            = "pipasad"
#   resource_group_name = "rgasad"
#   pip_location        = "centralindia"
# }

# data "azurerm_public_ip" "pip_data" {
#   depends_on          = [module.public_IP]
#   name                = "pipasad"
#   resource_group_name = "rgasad"
# }

# module "resource_group_kv" {
#   source                  = "../../modules/azurerm_resource_group"
#   resource_group_name     = "rgkeyvault"
#   resource_group_location = "centralindia"
# }

# resource "azurerm_key_vault" "keyvault" {
#   depends_on                  = [module.resource_group_kv, data.azurerm_client_config.tenantdata]
#   name                        = "asadkeyvault"
#   location                    = "centralindia"
#   resource_group_name         = "rgkeyvault"
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.tenantdata.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false

#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.tenantdata.tenant_id
#     object_id = data.azurerm_client_config.tenantdata.object_id

#     key_permissions = [
#       "Get",
#     ]

#     secret_permissions = [
#       "Get",
#       "Set",
#       "List",
#       "Delete"
#     ]

#     storage_permissions = [
#       "Get",
#     ]
#   }
# }

# data "azurerm_client_config" "tenantdata" {}

# data "azurerm_key_vault" "keyvault_data" {
#   depends_on          = [azurerm_key_vault.keyvault]
#   name                = "asadkeyvault"
#   resource_group_name = "rgkeyvault"
# }

# resource "azurerm_key_vault_secret" "vm_username" {
#   depends_on   = [azurerm_key_vault.keyvault, data.azurerm_key_vault.keyvault_data]
#   name         = "frontendvm-username"
#   value        = "asadlinuxfrontendvm"
#   key_vault_id = data.azurerm_key_vault.keyvault_data.id
# }

# data "azurerm_key_vault_secret" "vm_username_data" {
#   depends_on   = [data.azurerm_key_vault.keyvault_data]
#   name         = "frontendvm-username"
#   key_vault_id = data.azurerm_key_vault.keyvault_data.id
# }

# resource "azurerm_key_vault_secret" "vm_password" {
#   depends_on   = [azurerm_key_vault.keyvault, data.azurerm_key_vault.keyvault_data]
#   name         = "frontendvm-password"
#   value        = "AsadL!nuxfro0ntendVM"
#   key_vault_id = data.azurerm_key_vault.keyvault_data.id
# }

# data "azurerm_key_vault_secret" "vm_password_data" {
#   depends_on   = [data.azurerm_key_vault.keyvault_data]
#   name         = "frontendvm-password"
#   key_vault_id = data.azurerm_key_vault.keyvault_data.id
# }