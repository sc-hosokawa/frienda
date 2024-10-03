variable "project_id" {
  description = "The ID of the project in which resources will be managed."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "asia-northeast1"
}

variable "frienda_server_image" {
  description = "Docker image for frienda server"
  type        = string
}

variable "secret_id" {
  description = "ID of the secret in Secret Manager"
  type        = string
}
