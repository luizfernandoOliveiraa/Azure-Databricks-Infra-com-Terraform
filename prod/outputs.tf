output "resource_group_name" {
  value = module.data_engineering_prod.resource_group_name
}

output "datalake_name" {
  value = module.data_engineering_prod.datalake_name
}

output "data_factory_name" {
  value = module.data_engineering_prod.data_factory_name
}

output "databricks_workspace_url" {
  value = module.data_engineering_prod.databricks_workspace_url
}
