terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "backend" {
  name = var.image_name
  build {
    context    = abspath(var.build_context)
    dockerfile = var.dockerfile
  }
  keep_locally = true
}

resource "docker_container" "backend" {
  name  = "${var.resource_prefix}-backend"
  image = docker_image.backend.image_id
  restart = "unless-stopped"

  env = [
    "PORT=${var.port}",
    "DB_HOST=${var.database_host}",
    "DB_PORT=${var.database_port}",
    "DB_USER=${var.database_user}",
    "DB_PASSWORD=${var.database_password}",
    "DB_NAME=${var.database_name}"
  ]

  networks_advanced {
    name    = var.network_name
    aliases = [var.container_alias]
  }

  healthcheck {
    test     = ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:${var.port}${var.healthcheck_path}"]
    interval = var.healthcheck_interval
    timeout  = var.healthcheck_timeout
    retries  = var.healthcheck_retries
  }
}