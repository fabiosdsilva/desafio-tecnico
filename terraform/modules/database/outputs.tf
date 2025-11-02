output "container_name" {
  value = docker_container.database.name
}

output "database_host" {
  value = docker_container.database.name
}

output "database_port" {
  value = 5432
}

output "volume_name" {
  value = docker_volume.postgres_data.name
}