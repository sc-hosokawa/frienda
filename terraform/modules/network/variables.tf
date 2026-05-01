variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "region" {
  type        = string
  description = "The region"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "connector_name" {
  type        = string
  description = "The name of the VPC Access Connector"
}

variable "ip_cidr_range" {
  type        = string
  description = "The IP CIDR range for the VPC Access Connector"
  default     = "10.20.0.0/28"
}

variable "private_ip_name" {
  type        = string
  description = "The name of the private IP allocation"
}
