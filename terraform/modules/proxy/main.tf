terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "proxy" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "proxy" {
  name  = "${var.resource_prefix}-proxy"
  image = docker_image.proxy.image_id
  restart = "unless-stopped"

  ports {
    internal = var.internal_port
    external = var.external_port
    ip       = "0.0.0.0"
  }

  volumes {
    host_path      = abspath(var.config_path)
    container_path = "/etc/nginx/nginx.conf"
    read_only      = true
  }

  volumes {
    host_path      = abspath(var.static_files_path)
    container_path = "/usr/share/nginx/html"
    read_only      = true
  }

  # Connect to external network
  networks_advanced {
    name = var.external_network_name
  }

  # Connect to internal network
  networks_advanced {
    name    = var.internal_network_name
    aliases = [var.container_alias]
  }
}