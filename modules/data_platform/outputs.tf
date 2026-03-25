output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "datalake_name" {
  description = "Name of the ADLS Gen2 Storage Account"
  value       = azurerm_storage_account.datalake.name
}

output "data_factory_name" {
  description = "Name of the Azure Data Factory"
  value       = azurerm_data_factory.adf.name
}

output "databricks_workspace_url" {
  description = "URL of the Azure Databricks Workspace"
  value       = azurerm_databricks_workspace.dbw.workspace_url
}
