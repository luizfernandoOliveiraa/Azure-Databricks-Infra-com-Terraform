variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus"
}

variable "location_suffix" {
  type        = string
  description = "Suffix for location in naming conventions (e.g., eus)"
  default     = "eus"
}

variable "cost_center" {
  type        = string
  description = "FinOps cost center tag"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for the resources"
  default     = {}
}

variable "storage_replication_type" {
  type        = string
  description = "Storage account replication type (LRS, GRS, etc.)"
  default     = "LRS"
}

variable "databricks_sku" {
  type        = string
  description = "Databricks workspace SKU (standard, premium)"
  default     = "standard"
}
