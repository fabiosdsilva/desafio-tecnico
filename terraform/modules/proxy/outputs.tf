output "container_name" {
  value = docker_container.proxy.name
}

output "public_url" {
  value = "http://localhost:${var.external_port}"
}