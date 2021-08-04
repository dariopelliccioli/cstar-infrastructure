terraform {
  required_version = ">=0.15.3"

  backend "azurerm" {
    container_name = "cstar-psql-state"
    key            = "terraform-cstar-psql.tfstate"
  }

  required_providers {
    azurerm = {
      version = "~> 2.70.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.13.0"
    }
  }
}

data "azurerm_key_vault" "key_vault" {
  name                = format("cstar-%s-kv", var.env_short)
  resource_group_name = format("cstar-%s-sec-rg", var.env_short)
}

data "azurerm_key_vault_secret" "psql_admin_username" {
  name         = "db-administrator-login"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}


data "azurerm_key_vault_secret" "psql_admin_password" {
  name         = "db-administrator-login-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}


provider "postgresql" {
  host             = var.psql_hostname
  port             = var.psql_port
  username         = join("@", [data.azurerm_key_vault_secret.psql_admin_username.value ,var.psql_servername])
  password         = join("@", [data.azurerm_key_vault_secret.psql_admin_password.value ,var.psql_servername])
  sslmode          = "require"
  expected_version = "10"
  superuser        = false
  connect_timeout  = 15
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault_secrets" "user_secrets" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
}


data "azurerm_key_vault_secret" "db_users" {
  for_each = {for name in data.azurerm_key_vault_secrets.user_secrets.names:
                name => name if split("-", name)[0] == "dbuser"}
  
  name     = each.key
  key_vault_id = data.azurerm_key_vault.key_vault.id
}