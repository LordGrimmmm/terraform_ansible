terraform {
  backend "azurerm" {
    resource_group_name  = "n01697923-tfstate-rg"
    storage_account_name = "n01697923tfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
