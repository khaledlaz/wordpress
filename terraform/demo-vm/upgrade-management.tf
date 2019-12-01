data "azurerm_public_ip" "example" {
  name                = "${azurerm_public_ip.example.name}"
  resource_group_name = "${azurerm_resource_group.azureblr_demo_rg.name}"
}

output "public_ip_address" {
  value = "${data.azurerm_public_ip.example.ip_address}"
}