locals {
  default_tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
    CostCenter  = var.cost_center
  }
  tags = merge(local.default_tags, var.tags)
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}-${var.environment}-${var.location_suffix}"
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "datalake" {
  name                     = "st${var.project}${var.environment}${var.location_suffix}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = var.storage_replication_type
  is_hns_enabled           = true # Enable Hierarchical Namespace for ADLS Gen2

  tags = local.tags
}

resource "azurerm_data_factory" "adf" {
  name                = "adf-${var.project}-${var.environment}-${var.location_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = local.tags
}

resource "azurerm_databricks_workspace" "dbw" {
  name                = "dbw-${var.project}-${var.environment}-${var.location_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.databricks_sku

  custom_parameters {
    # FinOps: Setting no_public_ip to false prevents the requirement of a managed NAT Gateway.
    # The cluster nodes will get their own public IP for outbound connectivity, which is cheaper.
    no_public_ip = false
  }

  tags = local.tags
}
