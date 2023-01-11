resource "azurerm_virtual_network" "vnet" {
    resource_group_name = azurerm_resource_group.aks.name
    location = var.location
    name= var.virtual_network_name
    aaddress_space = [var.vnet-address] 
}

resource "azurerm_subnet" "AKSsubnet" {
    resource_group_name = azurerm_resource_group.aks.name
    name = var.subnet_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [var.subnet-address]
    
  lifecycle {
    ignore_changes = [enforce_private_link_endpoint_network_policies]
  }
  
}

resource "azurerm_subnet" "privateendpoint" {
    name= "myprivate_endpoint"
    resource_group_name = azurerm_kubernetes_cluster.aks.name
    virtual_virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [var.private-endpoint-subnet]
    enforce_private_link_endpoint_network_policies = true
  
}


resource "azurerm_subnet" "fwsubnet" {
    name = "fw_subnet"
    resource_group_name = azurerm_resource_group.aks.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_perfixes = [var.FW-subnet]  
}

resource "azurerm_route_table" "rt" {
  
      name = var.route_table
      location = azurerm_resource_group.aks.location
      resource_group_name = azurerm_resource_group.aks.name
      disable_bgp_route_propagation = false
      
      route{
       name =  "k8sfw"
       address_prefix = "0.0.0.0/0"
       next_hop_type = "VirtualAppliance"
       next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address        

      }

      depends_on = [
        azurerm_firewall.fw
      ]
}

resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
     subnet_id = azurerm_subnet.AKSsubnet.id
     route_table_id = azurerm_route_table.rt.id
}


