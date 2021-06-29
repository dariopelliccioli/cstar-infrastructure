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
}

## Firewall subnet
module "hub_firewall_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                 = "AzureFirewallSubnet"
  address_prefixes     = var.cidr_hub_firewall_subnet
  resource_group_name  = azurerm_resource_group.rg_hub_vnet.name
  virtual_network_name = module.hub_vnet.name
}

resource "azurerm_network_security_group" "hub_mgmt_nsg" {
  name                = format("%s-hub-mng-nsg", local.project)
  location            = azurerm_resource_group.rg_hub_vnet.location
  resource_group_name = azurerm_resource_group.rg_hub_vnet.name
}

resource "azurerm_network_security_rule" "nsg_hub_rules" {
  count                       = length(var.hub_mgmt_rules)
  name                        = lookup(var.hub_mgmt_rules[count.index], "name", "defaultruleplaceholder")
  priority                    = lookup(var.hub_mgmt_rules[count.index], "priority", 64999)
  direction                   = lookup(var.hub_mgmt_rules[count.index], "direction", "Inbound")
  access                      = lookup(var.hub_mgmt_rules[count.index], "access", "Deny")
  protocol                    = lookup(var.hub_mgmt_rules[count.index], "protocol", "udp")
  source_port_range           = lookup(var.hub_mgmt_rules[count.index], "source_port_ranges", "8888")
  source_address_prefix       = lookup(var.hub_mgmt_rules[count.index], "source_address_prefix", "8.8.8.8/32")
  destination_port_range      = lookup(var.hub_mgmt_rules[count.index], "destination_port_ranges", "8888")
  destination_address_prefix  = lookup(var.hub_mgmt_rules[count.index], "destination_address_prefix", "8.8.8.8/32")
  description                 = lookup(var.hub_mgmt_rules[count.index], "description", "defaultplaceholder")
  resource_group_name         = azurerm_resource_group.rg_hub_vnet.name
  network_security_group_name = azurerm_network_security_group.hub_mgmt_nsg.name
}

module "hub_firewall" {
  source              = "/Users/uolter/src/pagopa/azurerm/firewall"
  name                = format("%s-hub-firewall", local.project)
  location            = azurerm_resource_group.rg_hub_vnet.location
  resource_group_name = azurerm_resource_group.rg_hub_vnet.name

  ip_configurations = [{
    name      = format("subnet-config")
    subnet_id = module.hub_firewall_snet.id
  }]

  tags = var.tags

}