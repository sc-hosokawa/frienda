variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "asia-northeast1"
}

variable "frienda_server_image" {
  description = "Docker image for frienda server"
  type        = string
}

variable "db_password" {
  description = "Database user password"
  type        = string
}
