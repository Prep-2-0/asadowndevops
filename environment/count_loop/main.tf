# resource "azurerm_resource_group" "rgs" {
#   count = 5
#   name = "rgasad"
#   location = "centralindia"
# }

# resource "azurerm_resource_group" "rgs" {
#   count = 5
#   name = "rgasad-${count.index}"
#   location = "centralindia"
# }

variable "rg-names" {
  type = list(string)
}

variable "rg-location" {
  type = list(string)
}

resource "azurerm_resource_group" "rgs" {
  count = length(var.rg-names)
  
  name = var.rg-names[count.index]
  location = var.rg-location [count.index]
}



# default = [ "rg-asad", "rg-diksha", "rg-shivam", "rg-ashish", "rg-mehul" ]