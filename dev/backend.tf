terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-storageaccount"
    storage_account_name = "tfstatedatabricksluiz"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
