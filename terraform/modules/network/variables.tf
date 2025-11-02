variable "resource_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "internal_network_restricted" {
  type        = bool
  description = "Whether internal network should be restricted"
  default     = true
}