output "application_url" {
  description = "URL pública da aplicação"
  value       = module.proxy.public_url
}

output "database_info" {
  description = "Informações do banco de dados"
  value       = {
    host     = module.database.database_host
    port     = module.database.database_port
    database = var.database_name
    user     = var.database_user
  }
  sensitive = true
}

output "network_info" {
  description = "Informações das redes"
  value       = {
    external = module.network.external_network_name
    internal = module.network.internal_network_name
  }
}

output "containers_created" {
  description = "Containers criados"
  value       = [
    module.database.container_name,
    module.backend.container_name,
    module.proxy.container_name
  ]
}