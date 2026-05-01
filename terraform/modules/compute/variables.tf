variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "region" {
  type        = string
  description = "The region"
}

variable "environment" {
  type        = string
  description = "The environment name (dev, prod, test)"
}

variable "network_id" {
  type        = string
  description = "The ID of the VPC network"
}

variable "connector_id" {
  type        = string
  description = "The ID of the VPC Access Connector"
}

variable "db_instance_name" {
  type        = string
  description = "The name of the Cloud SQL instance"
}

variable "db_tier" {
  type        = string
  description = "The tier of the Cloud SQL instance"
  default     = "db-custom-1-3840"
}

variable "db_password" {
  type        = string
  description = "The password for the DB user (if not provided, a random one will be generated)"
  default     = ""
  sensitive   = true
}

variable "run_service_name" {
  type        = string
  description = "The name of the Cloud Run service"
}

variable "frienda_server_image" {
  type        = string
  description = "The image of the frienda server"
}

variable "frienda_server_image_tag" {
  type        = string
  description = "The image tag of the frienda server"
  default     = "latest"
}

variable "min_instance_count" {
  type        = number
  description = "Minimum number of Cloud Run instances"
  default     = 0
}

variable "max_instance_count" {
  type        = number
  description = "Maximum number of Cloud Run instances"
  default     = 10
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for Cloud SQL"
  default     = true
}

variable "backup_enabled" {
  type        = bool
  description = "Whether to enable backups for Cloud SQL"
  default     = false
}

variable "pitr_enabled" {
  type        = bool
  description = "Whether to enable point-in-time recovery for Cloud SQL"
  default     = false
}

variable "security_policy_id" {
  type        = string
  description = "The ID of the Cloud Armor security policy"
  default     = null
}

variable "lb_name" {
  type        = string
  description = "The name for the Load Balancer resources"
  default     = "frienda-lb"
}
