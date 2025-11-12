# resource "azurerm_resource_group" "rgs" {
#   for_each = toset ([ "rg-asad", "rg-diksha", "rg-shivam" ])
#   name = each.key
#   location = "centralindia"
# }


variable "rg-names" {
  type = set(string)
}

resource "azurerm_resource_group" "rgs" {
  for_each = toset (var.rg-names)
  name = each.value
  location = "centralindia"
}