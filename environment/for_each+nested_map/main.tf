variable "saare-rgs" {
  type = map(any)
}

resource "azurerm_resource_group" "rgs" {
  for_each = var.saare-rgs
  
  name = each.value.name
  location = each.value.location
}