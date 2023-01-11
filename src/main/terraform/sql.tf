resource "azurerm_sql_server" "sqlserver" {
    name= var.sql_server_name
    resource_group_name = azurerm_resource_group.aks.name
    location = azurerm_resource_group.aks.location
    version = "12.0"
    administrator_login          = var.sql_server_admin_login
    administrator_login_password = var.sql_server_admin_pwd
  
}

resource "azurerm_sql_database" "sqldb" {
   name=  var.sql_db_name
   server_name = azurerm_sql_server.sqlserver.name
   resource_group_name = azurerm_resource_group.aks.name
   location = azurerm_resource_group.aks.location
   edition = 



}