variable "project_name" {
  type        = string
  description = "Nome do projeto"
  default     = "secure-app"
}

variable "environment" {
  type        = string
  description = "Ambiente de deploy"
  default     = "dev"
}

# Database Variables
variable "postgres_image" {
  type        = string
  description = "Imagem do PostgreSQL"
  default     = "postgres:15-alpine"
}

variable "database_name" {
  type        = string
  description = "Nome do banco de dados"
  default     = "appdb"
}

variable "database_user" {
  type        = string
  description = "Usuário do banco de dados"
  default     = "appuser"
}

variable "database_password" {
  type        = string
  description = "Senha do banco de dados"
  sensitive   = true
}

# Backend Variables
variable "backend_image_name" {
  type        = string
  description = "Nome da imagem do backend"
  default     = "secure-app-backend"
}

variable "backend_port" {
  type        = number
  description = "Porta do backend"
  default     = 3001
}

# Proxy Variables
variable "proxy_image" {
  type        = string
  description = "Imagem do Nginx"
  default     = "nginx:alpine"
}

variable "proxy_port" {
  type        = number
  description = "Porta do proxy"
  default     = 8080
}

# Healthcheck Variables
variable "healthcheck_interval" {
  type        = string
  description = "Intervalo do healthcheck"
  default     = "30s"
}

variable "healthcheck_timeout" {
  type        = string
  description = "Timeout do healthcheck"
  default     = "10s"
}

variable "healthcheck_retries" {
  type        = number
  description = "Tentativas do healthcheck"
  default     = 3
}