resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = "West US 2"
}

resource "azurerm_datadog_monitor" "main" {
  name                = "main-monitor"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  monitoring_enabled  = true
  datadog_organization {
    api_key         = var.api_key
    application_key = var.app_key
  }
  user {
    name  = "Salem Affes"
    email = "affessalem@hotmail.fr"
  }
  sku_name = "Linked"
  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_datadog_monitor_tag_rule" "main" {
  datadog_monitor_id = azurerm_datadog_monitor.main.id
  log {
    subscription_log_enabled = true
    aad_log_enabled          = true
    resource_log_enabled     = true
    filter {
      name   = "environment"
      value  = "prod"
      action = "Include"
    }
  }

  metric {
    filter {
      name   = "environment"
      value  = "prod"
      action = "Include"
    }
  }

}

# Allow metrics flow (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/datadog_monitors#role-assignment-on-the-monitor-created)
data "azurerm_subscription" "primary" {}
data "azurerm_role_definition" "monitoring_reader" {
  name = "Monitoring Reader"
}
resource "azurerm_role_assignment" "main" {
  scope              = data.azurerm_subscription.primary.id
  # Attache subscription and id since it recreates the resource each time
  role_definition_id = "/subscriptions/${var.subscription_id}${data.azurerm_role_definition.monitoring_reader.role_definition_id}"
  principal_id       = azurerm_datadog_monitor.main.identity[0].principal_id
}


data "azurerm_service_plan" "main" {
  name                = "ASP-default-9999"
  resource_group_name = "default"
}


resource "azurerm_linux_web_app" "main" {
  name                = "mydatadogwebapp"
  resource_group_name = azurerm_resource_group.main.name
  location            = data.azurerm_service_plan.main.location
  service_plan_id     = data.azurerm_service_plan.main.id

  site_config {
    always_on = false


  }
  tags = var.tags
}

resource "azurerm_storage_account" "main" {
  name                     = "mydatadogspedialstorage"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = var.tags
}
