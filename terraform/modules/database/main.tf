terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_volume" "postgres_data" {
  name = "${var.resource_prefix}-postgres-data"
}

resource "docker_image" "postgres" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "database" {
  name  = "${var.resource_prefix}-database"
  image = docker_image.postgres.image_id
  restart = "unless-stopped"

  env = [
    "POSTGRES_DB=${var.database_name}",
    "POSTGRES_USER=${var.username}",
    "POSTGRES_PASSWORD=${var.password}"
  ]

  dynamic "volumes" {
    for_each = var.data_volume_enabled ? [1] : []
    content {
      volume_name    = docker_volume.postgres_data.name
      container_path = "/var/lib/postgresql/data"
    }
  }

  dynamic "volumes" {
    for_each = var.init_script_path != null ? [1] : []
    content {
      host_path      = abspath(var.init_script_path)
      container_path = "/docker-entrypoint-initdb.d/script.sql"
      read_only      = true
    }
  }

  networks_advanced {
    name    = var.network_name
    aliases = [var.container_alias]
  }

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U ${var.username} -d ${var.database_name}"]
    interval = var.healthcheck_interval
    timeout  = var.healthcheck_timeout
    retries  = var.healthcheck_retries
  }
}