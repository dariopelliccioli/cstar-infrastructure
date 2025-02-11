terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 1.6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "Prod-Sec"
  subscription_id = data.azurerm_key_vault_secret.sec_sub_id.value
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
