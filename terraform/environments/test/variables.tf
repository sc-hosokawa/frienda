variable "project_id" {
  type        = string
  description = "The project ID"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "The region"
  default     = "asia-northeast1"
}

variable "frienda_server_image" {
  type        = string
  description = "The image of the frienda server"
  sensitive   = true
}

variable "frienda_server_image_tag" {
  type        = string
  description = "The image tag of the frienda server"
  default     = "latest"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "The password of the database"
  sensitive   = true
}
