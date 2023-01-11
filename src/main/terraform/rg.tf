resource "azurerm_resource_group" "aks" {
    name = var.resource_group
    location= var.location
}