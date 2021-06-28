resource "azurerm_resource_group" "rg_hub_vnet" {
  name     = format("%s-hub-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

module "hub_vnet" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.7"
  name                = format("%s-hub-vnet", local.project)
  location            = azurerm_resource_group.rg_hub_vnet.location
  resource_group_name = azurerm_resource_group.rg_hub_vnet.name
  address_space       = var.cidr_hub_vnet

  tags = var.tags
}

## Management subnet
module "hub_mng_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                 = format("%s-hub-mng-snet", local.project)
  address_prefixes     = var.cidr_hub_mng_subnet
  resource_group_name  = azurerm_resource_group.rg_hub_vnet.name
  virtual_network_name = module.hub_vnet.name
  # enforce_private_link_endpoint_network_policies = true
}

## Firewall subnet
module "hub_firewall_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                 = format("%s-hub-firewall-snet", local.project)
  address_prefixes     = var.cidr_hub_firewall_subnet
  resource_group_name  = azurerm_resource_group.rg_hub_vnet.name
  virtual_network_name = module.hub_vnet.name
  # enforce_private_link_endpoint_network_policies = true
}