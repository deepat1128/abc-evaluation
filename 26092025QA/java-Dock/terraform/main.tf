resource "random_id" "unique_id" {
  byte_length = 4
}

resource "azurerm_container_group" "docker_demo" {
  name                = "demo-container-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label = "demo-training-deepa-1128"  # append date or random suffix 


  container {
    name   = "demo-training"
    image  = var.docker_image   # <-- replace hardcoded image
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}

output "app_url" {
  description = "Public URL of the Docker container"
  value       = "http://${azurerm_container_group.docker_demo.dns_name_label}.north-europe.azurecontainer.io:8080"
}

