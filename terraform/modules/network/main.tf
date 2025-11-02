terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_network" "external" {
  name   = "${var.resource_prefix}-external"
  driver = "bridge"
}

resource "docker_network" "internal" {
  name     = "${var.resource_prefix}-internal"
  driver   = "bridge"
  internal = var.internal_network_restricted
}