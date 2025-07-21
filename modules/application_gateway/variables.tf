variable "application_gateway_name" {
  description = "Name of the Application Gateway."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network for the Application Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Application Gateway will be deployed."
  type        = string
}

variable "location" {
  description = "Location for all resources."
  type        = string
  default     = ""
}

variable "autoscale_configuration" {
  description = "Upper and lower bounds on the number of Application Gateway instances."
  type = object({
    minCapacity = number
    maxCapacity = number
  })
  default = {
    minCapacity = 0
    maxCapacity = 4
  }
}

variable "firewall_policy_id" {
  description = "Resource ID of an associated firewall policy for the Application Gateway."
  type        = string
  default     = null
}

# variable "backend_address_pools" {
#   description = "Backend address pools of the Application Gateway."
#   type        = list(object({
#     name      = string
#     addresses = list(object({ ip_address = string }))
#   }))
#   default     = []
# }

variable "subnet_id" {
  description = "The ID of the subnet for the Application Gateway."
  type        = string
}

variable "gateway_ip_configuration_name" {
  description = "The name of the gateway IP configuration for the Application Gateway."
  type        = string

}

variable "frontend_ip_configuration_name" {
  description = "The name of the frontend IP configuration for the Application Gateway."
  type        = string

}

variable "frontend_ip_configurations" {
  description = "Frontend IP configurations of the Application Gateway."
  type = list(object({
    name = string
    properties = object({
      private_ip_allocation_method = string
      public_ip_address            = object({ id = string })
      private_ip_address           = string
    })
  }))
  default = [
    {
      name = "public"
      properties = {
        private_ip_allocation_method = "Dynamic"
        public_ip_address = {
          id = ""
        }
      }
    }
  ]
}

variable "http_listeners" {
  description = "HTTP listeners of the Application Gateway."
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
  }))
  default = []
}

variable "probes" {
  description = "Probes of the Application Gateway."
  type        = list(any)
  default     = []
}

variable "redirect_configurations" {
  description = "Redirect configurations of the Application Gateway."
  type        = list(any)
  default     = []
}

variable "private_link_configurations" {
  description = "Private Link configurations of the Application Gateway."
  type        = list(any)
  default     = []
}

variable "request_routing_rules" {
  description = "Request routing rules of the Application Gateway."
  type        = list(any)
  default     = []
}

variable "rewrite_rule_sets" {
  description = "Rewrite rules for the Application Gateway."
  type        = list(any)
  default     = []
}

variable "sku" {
  description = "SKU for the Application Gateway (e.g., WAF_v2, Standard_v2)."
  type        = string
  default     = "WAF_v2"
}


variable "gateway_ip_configurations" {
  description = "Gateway IP configurations of the Application Gateway."
  type        = list(any)
  default     = []
}

variable "ssl_policy" {
  description = "SSL policy for the Application Gateway."
  type = object({
    policy_name          = string
    policy_type          = string
    min_protocol_version = string
    cipher_suites        = list(string)
  })
  default = {
    policy_name          = "AppGwSslPolicy20170401S"
    policy_type          = "Predefined"
    min_protocol_version = "TLSv1_2"
    cipher_suites        = []
  }
}

variable "url_path_maps" {
  description = "URL path maps of the Application Gateway."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

variable "public_ip_address_id" {
  description = "Public IP address ID for the Application Gateway."
  type        = string
}

variable "private_ip_address" {
  description = "Private IP address for the Application Gateway."
  type        = string
}

variable "backend_ip_addresses" {
  description = "List of backend IP addresses for the application gateway backend pool. This can include specific IPs or VM IPs."
  type        = list(string)
  default     = []
}

variable "capacity" {
  description = "The fixed capacity for the Application Gateway (used when autoscaling is not enabled)."
  type        = number
  default     = 2 # Adjust as needed
}

variable "backend_address_pools" {
  description = "List of backend address pools, each containing a name and a list of IP addresses."
  type = list(object({
    name         = string
    ip_addresses = list(string)
    fqdns        = list(string)
  }))
}

variable "ssl_certificates" {
  description = "List of SSL certificates with their names and Key Vault secret IDs"
  type = list(object({
    name     = string
    data     = string
    password = string
  }))
}


variable "backend_http_settings_collection" {
  description = "List of backend HTTP settings configurations."
  type = list(object({
    name                  = string
    cookie_based_affinity = string
    protocol              = string
    port                  = number
    connection_draining   = string
    host_name             = string
    request_timeout       = number
  }))
}

variable "frontend_ports" {
  description = "List of frontend ports for the Application Gateway."
  type = list(object({
    name = string
    port = number
  }))
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
}

variable "storage_account_id" {
  description = "The name of the hub storage account to store logs"
  default     = null
}

# variable "request_routing_rules" {
#   description = "List of request routing rules."
#   type = list(object({
#     name                       = string
#     priority                   = number
#     rule_type                  = string
#     http_listener_name         = string
#     backend_address_pool_name  = string
#     backend_http_settings_name = string
#   }))
# }
