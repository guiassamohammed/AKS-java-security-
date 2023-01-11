resource "azurerm_kubernetes_cluster" "aks" {
    resource_group_name = azurerm_resource_group.aks.name
    location = azurerm_resource_group.aks.location
    name= "${var.aks-prefix}-aks"
    dns_prefix ="${var.aks-prefix}-aks"
    
    role_based_access_control {

       enabled = true
       azure_active_directory{
          managed = true
          admin_group_object_ids = [var.aks_admin_group_id]
          tenant_id = var.tenant_id
       }
    }
       

    default_node_pool {
      name = sysnodepool
      node_count= var.system_nodepool_nodes_count
      vm_size = var.system_nodepool_nodes_size
      max_pods = 100
      min_count = 1
      max_count = 7
      enable_enable_auto_scaling = true  
      type = "VirtualMachineScaleSets"
      vnet_subnet_id = azurerm_subnet.AKSsubnet.id

    }
    
    kubernetes_version = var.kubernetes-version
    
    network_profile {
       network_plugin = "azure"
       network_policy = "azure"
       dns_service_ip = "10.1.0.10"
       docker_bridge_cidr = "172.17.0.1/16"
       service_cidr = "172.16.0.0/16"

       load_balancer_sku = "standard"
       outbound_type = "userDefinedRouting"
    }

    addon_profile{
      
      azure_policy {
        enabled = true
       }
      http_application_routing {
      enabled = false
      }
      aci_connector_linux {
       enabled = false
      }
      oms_agent {
      enabled = true
      log_analytics_workspace_id =  azurerm_log_analytics_workspace.main.id
      }

    }
    identity {
    type = "SystemAssigned"
    }

    depends_on = [
      azurerm_subnet_AKSsubnet, azirerm_route_table.rt, 
      azurerm_subnet_route_table_association.aks_subnet_association

    ]

}

resource "azurerm_log_analytics_workspace" "main" {

  name = "${var.aks-prefix}-lg-workspace"
  location = azurerm_resource_group.location
  resource_group_name = azurerm_resource_group.name
  sku = var.log_analytics_workspace_sku
  retention_in_days= var.log_retention_in_days
}


resource "azurerm_log_analytics_solution" "container" {
  solution_name = "ContainerInsights"
  location = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name = azurerm_log_analytics_workspace.main.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
 
}

resource "azurerm_container_registry" "acr" {
  name= var.azure_acr
  resource_group_name = azurerm_resource_group.aks.name
  location = azurerm_resource_group.aks.location
  sku = "Standard"
  admin_enabled = false
  

  depends_on = [azurerm_kubernetes_cluster.aks]

  provisioner local-exec {

    command = "az aks update --resource-group ${azurerm_resource_group.aks.name} --name ${var.aks-prefix}-aks  --attach-acr= ${var.azure_acr} " 
    environment = {
            AZURE_EXTENSION_USE_DYNAMIC_INSTALL = "yes_without_prompt"
     }

  }


}
