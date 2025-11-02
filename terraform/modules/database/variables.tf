variable "resource_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "image" {
  type        = string
  description = "PostgreSQL image"
  default     = "postgres:15-alpine"
}

variable "database_name" {
  type        = string
  description = "Database name"
}

variable "username" {
  type        = string
  description = "Database username"
}

variable "password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "network_name" {
  type        = string
  description = "Network name to attach"
}

variable "container_alias" {
  type        = string
  description = "Container network alias"
  default     = "database"
}

variable "data_volume_enabled" {
  type        = bool
  description = "Enable data volume"
  default     = true
}

variable "init_script_path" {
  type        = string
  description = "Path to initialization SQL script"
  default     = null
}

variable "healthcheck_interval" {
  type        = string
  default     = "30s"
}

variable "healthcheck_timeout" {
  type        = string
  default     = "10s"
}

variable "healthcheck_retries" {
  type        = number
  default     = 3
}