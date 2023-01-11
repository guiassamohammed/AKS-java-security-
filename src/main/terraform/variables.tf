variable "resource_group" {
    type = string
    default = "Aks-Java"
  
}

variable "location"{
   type = string 
   default = "westeurope"
}

variable "aks-prefix"{
    type = string
    default = "aksspringboot"
}

variable "system_nodepool_nodes_count" {
    type = number
    default = 3
  
}
variable "system_nodepool_nodes_size"{
   type =string
   default = "Standard_D2_v2"

}

variable "virtual_network_name" {
    type = string
    default = "myvnet"
}

variable "vnet-address" {
    type = string
    default = "10.1.0.0/8"  
}

variable "subnet_name" {
    type = string
    default = "mysubnet"
  
}

variable "subnet-address" {
    type = string
    default = "10.1.0.0/16"  
}

variable "private-endpoint-subnet" {
    type = string
    default = "10.1.0.0/18"  
}

variable "FW-subnet" {
    type = string
    default = "10.1.1.0/20"  
}

variable "route_table" {
    type = string
    default = "Aksroute"  
}

variable "pip_name"{
   type = string
   default = "pip"

}

variable "fw_name" {
  type= string
  default = "myazure_FW"   
  
}

variable "kubernetes-version" {
  type = string
  default = "1.24"
}

variable "log_analytics_workspace_sku" {
  description = "sku"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days"
  type        = number
  default     = 30
}

variable "azure_acr" {
  type        = string
  default     = "myazure_acr"
}

variable "aks_admin_group_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "sql_server_name" {
  type = string
  default= "mysqlserver"
}

variable "sql_server_admin_pwd" {
  type = string
}

variable "sql_server_admin_login" {
  type = string
}

variable "sql_db_name" {
  type = string
}