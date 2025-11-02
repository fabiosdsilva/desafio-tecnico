terraform {
  required_version = ">= 1.0"
  
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "docker" {}

# Network
module "network" {
  source = "../../modules/network"
  
  resource_prefix = "${var.project_name}-${var.environment}"
}

# Database
module "database" {
  source = "../../modules/database"
  
  resource_prefix    = "${var.project_name}-${var.environment}"
  image              = var.postgres_image
  database_name      = var.database_name
  username           = var.database_user
  password           = var.database_password
  network_name       = module.network.internal_network_name
  init_script_path   = "../../../sql/script.sql"
  
  healthcheck_interval = var.healthcheck_interval
  healthcheck_timeout  = var.healthcheck_timeout
  healthcheck_retries  = var.healthcheck_retries
}

# Backend
module "backend" {
  source = "../../modules/backend"
  
  resource_prefix    = "${var.project_name}-${var.environment}"
  image_name         = var.backend_image_name
  build_context      = "../../../backend"
  port               = var.backend_port
  network_name       = module.network.internal_network_name
  
  # Database
  database_host      = module.database.database_host
  database_port      = module.database.database_port
  database_user      = var.database_user
  database_password  = var.database_password
  database_name      = var.database_name
  
  healthcheck_path     = "/api"
  healthcheck_interval = var.healthcheck_interval
  healthcheck_timeout  = var.healthcheck_timeout
  healthcheck_retries  = var.healthcheck_retries
  
  depends_on = [module.database]
}

# Proxy
module "proxy" {
  source = "../../modules/proxy"
  
  resource_prefix        = "${var.project_name}-${var.environment}"
  image                  = var.proxy_image
  external_port          = var.proxy_port
  config_path            = "../../../proxy/nginx.conf"
  static_files_path      = "../../../frontend"
  external_network_name  = module.network.external_network_name
  internal_network_name  = module.network.internal_network_name
  
  depends_on = [module.backend]
}