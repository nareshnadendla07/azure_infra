############################
## azure_application_gateway
############################

resource "azurerm_application_gateway" "example" {
  name                = var.application_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge({ "Name" = var.application_gateway_name }, var.tags)

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids

  }

  sku {
    name     = var.sku
    tier     = contains(["WAF_v2", "Standard_v2"], var.sku) ? "WAF_v2" : "Standard"
    capacity = var.sku == "WAF_v2" ? null : var.capacity
  }
  firewall_policy_id = var.firewall_policy_id != null ? var.firewall_policy_id : null

  autoscale_configuration {
    min_capacity = var.autoscale_configuration.minCapacity
    max_capacity = var.autoscale_configuration.maxCapacity
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_address_id != null ? var.public_ip_address_id : null
    private_ip_address   = var.private_ip_address != null ? var.private_ip_address : null
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      ip_addresses = backend_address_pool.value.ip_addresses != null ? backend_address_pool.value.ip_addresses : null
      fqdns        = backend_address_pool.value.fqdns != null ? backend_address_pool.value.fqdns : null
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates
    content {
      name     = ssl_certificate.value.name
      data     = ssl_certificate.value.data
      password = ssl_certificate.value.password
    }
  }


  # Dynamic block for backend HTTP settings
  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings_collection
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      protocol              = backend_http_settings.value.protocol
      port                  = backend_http_settings.value.port
      host_name             = backend_http_settings.value.host_name
      request_timeout       = backend_http_settings.value.request_timeout
    }
  }

  # Dynamic block for frontend ports
  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  # Dynamic block for HTTP listeners
  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = http_listener.value.protocol == "Https" ? var.ssl_certificates[0].name : null
    }
  }

  ssl_policy {
    policy_name          = var.ssl_policy.policy_name
    policy_type          = var.ssl_policy.policy_type
    min_protocol_version = var.ssl_policy.min_protocol_version
    cipher_suites        = var.ssl_policy.cipher_suites
  }

  # Request routing rule with dynamic backend settings
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                       = request_routing_rule.value.name
      priority                   = request_routing_rule.value.priority
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
  }

  
}

#####################
## Diagnostic Setting
#####################

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name                       = "${var.application_gateway_name}-diag"
  target_resource_id         = azurerm_application_gateway.example.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  enabled_metric {
    category = "AllMetrics"

  }
}
