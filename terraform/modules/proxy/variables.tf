variable "resource_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "image" {
  type        = string
  description = "Nginx image"
  default     = "nginx:alpine"
}

variable "external_port" {
  type        = number
  description = "External proxy port"
  default     = 8080
}

variable "internal_port" {
  type        = number
  description = "Internal proxy port"
  default     = 80
}

variable "config_path" {
  type        = string
  description = "Nginx config file path"
}

variable "static_files_path" {
  type        = string
  description = "Static files path"
}

variable "external_network_name" {
  type        = string
  description = "External network name"
}

variable "internal_network_name" {
  type        = string
  description = "Internal network name"
}

variable "container_alias" {
  type        = string
  description = "Container network alias"
  default     = "proxy"
}