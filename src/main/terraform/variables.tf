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