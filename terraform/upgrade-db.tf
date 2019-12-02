
resource "null_resource" "upgrade_database_v1" {
  
  triggers = {
      ids="${azurerm_virtual_machine.azureblr_demo_vm.id}"
  }

  connection {
    host        = "${azurerm_public_ip.azureblr_demo_public_ip.ip_address}"
    user        = "${var.vm_username}"
    private_key = "${tls_private_key.id_rsa.private_key_pem}"
  }
  
  provisioner "file" {
    content     = file("../db/v1.sql")
    destination = "/tmp/database.sql"
  }
  provisioner "remote-exec" {
    inline = [
      "mysql -u root ${local.wp_database_name} < /tmp/database.sql",
    ]
  }
}

output "instance_ip_addr" {
    value = "${azurerm_public_ip.azureblr_demo_public_ip}"
}
