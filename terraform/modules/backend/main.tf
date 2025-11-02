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
    "port=${var.port}",
    "host=${var.database_host}",
    "db_port=${var.database_port}",
    "user=${var.database_user}",
    "pass=${var.database_password}",
    "database=${var.database_name}"
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