module "data_engineering_dev" {
  source = "../modules/data_platform"

  environment              = "dev"
  project                  = "datalab" # kept short for storage account name limits
  location                 = "eastus2"
  location_suffix          = "eus2"
  cost_center              = "100-DataEng-Dev"
  storage_replication_type = "LRS"      # FinOps: Cheapest replication for Dev
  databricks_sku           = "standard" # FinOps: Standard SKU usually sufficient for Dev

  # DataOps/FinOps Tags
  tags = {
    Owner       = "Data Engineering Team"
    Criticality = "Low"
  }
}
