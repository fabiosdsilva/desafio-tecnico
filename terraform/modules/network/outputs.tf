output "external_network_id" {
  value = docker_network.external.id
}

output "external_network_name" {
  value = docker_network.external.name
}

output "internal_network_id" {
  value = docker_network.internal.id
}

output "internal_network_name" {
  value = docker_network.internal.name
}