module "data_engineering_prod" {
  source = "../modules/data_platform"

  environment              = "prod"
  project                  = "datalab"
  location                 = "eastus2"
  location_suffix          = "eus2"
  cost_center              = "DataEng-Prod"
  storage_replication_type = "LRS"     # DataOps/FinOps: Geo-redundancy for disaster recovery in Prod
  databricks_sku           = "premium" # DataOps/SecOps: Premium for conditional access and RBAC

  # DataOps/FinOps Tags
  tags = {
    Owner       = "Data Engineering Team"
    Criticality = "High"
  }
}
