# resource "azurerm_resource_group" "rgs" {
#   for_each = { 
#     "rg-asad" = "west us"
#     "rg-diksha" = "central india"
#     "rg-shivam" = "east us"
#     "rg-ashish" = "uk south"
#     }
#   name = "rg-asad1"
#   location = "centralindia"
# }

# resource "azurerm_resource_group" "rgs" {
#   for_each = { 
#     "rg-asad" = "west us"
#     "rg-diksha" = "central india"
#     "rg-shivam" = "east us"
#     "rg-ashish" = "uk south"
#     }
#   name = each.key
#   location = each.value
# }
  
  

variable "poora-rg" {
  type = map(string)
}

resource "azurerm_resource_group" "rgs" {
  for_each = var.poora-rg
  name = each.key
  location = each.value
}