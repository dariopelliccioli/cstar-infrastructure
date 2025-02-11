resource "azurerm_resource_group" "msg_rg" {
  name     = format("%s-msg-rg", local.project)
  location = var.location

  tags = var.tags
}


module "event_hub" {
  source                   = "git::https://github.com/pagopa/azurerm.git//eventhub?ref=v1.0.70"
  name                     = format("%s-evh-ns", local.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_integration.id, module.vnet.id]
  subnet_id           = module.eventhub_snet.id

  eventhubs = var.eventhubs

  alerts_enabled = var.ehns_alerts_enabled
  metric_alerts  = var.ehns_metric_alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "event_hub_keys" {
  for_each = module.event_hub.key_ids

  name         = format("evh-%s-%s", replace(each.key, ".", "-"), "key")
  value        = module.event_hub.keys[each.key].primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}



module "event_hub_fa_01" {
  source = "git::https://github.com/pagopa/azurerm.git//eventhub?ref=v1.0.70"


  name                     = format("%s-evh-ns-fa-01", local.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_integration.id, module.vnet.id]
  subnet_id           = module.eventhub_snet.id

  private_dns_zones              = module.event_hub.private_dns_zone
  private_dns_zone_record_A_name = "eventhubfa01"

  eventhubs = var.eventhubs_fa

  alerts_enabled = var.ehns_alerts_enabled
  metric_alerts  = var.ehns_metric_alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "event_hub_keys_fa_01" {
  for_each = module.event_hub_fa_01.key_ids

  name         = format("evh-%s-%s-fa-01", replace(each.key, ".", "-"), "key")
  value        = module.event_hub_fa_01.keys[each.key].primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
