variable "resource_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "image_name" {
  type        = string
  description = "Backend image name"
}

variable "build_context" {
  type        = string
  description = "Docker build context path"
}

variable "dockerfile" {
  type        = string
  description = "Dockerfile path"
  default     = "Dockerfile"
}

variable "port" {
  type        = number
  description = "Backend port"
  default     = 3001
}

variable "network_name" {
  type        = string
  description = "Network name to attach"
}

variable "container_alias" {
  type        = string
  description = "Container network alias"
  default     = "backend"
}

# Database connection variables
variable "database_host" {
  type        = string
  description = "Database host"
}

variable "database_port" {
  type        = number
  description = "Database port"
  default     = 5432
}

variable "database_user" {
  type        = string
  description = "Database user"
}

variable "database_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "database_name" {
  type        = string
  description = "Database name"
}

variable "healthcheck_path" {
  type        = string
  description = "Health check path"
  default     = "/api"
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