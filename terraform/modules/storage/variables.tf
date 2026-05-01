variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "region" {
  type        = string
  description = "The region"
}

variable "general_bucket_name" {
  type        = string
  description = "The name of the general file storage bucket"
}

variable "photo_bucket_name" {
  type        = string
  description = "The name of the photo storage bucket"
  default     = ""
}

variable "state_bucket_name" {
  type        = string
  description = "The name of the terraform state bucket"
  default     = ""
}

variable "sql_service_account_email" {
  type        = string
  description = "The service account email of the Cloud SQL instance"
  default     = ""
}

variable "enable_sql_iam_access" {
  type        = bool
  description = "Whether to enable IAM access for SQL service account"
  default     = false
}

variable "force_destroy" {
  type        = bool
  description = "Whether to force destroy buckets"
  default     = false
}

variable "delete_after_days" {
  type        = number
  description = "Number of days after which to delete objects (if 0, move to COLDLINE instead)"
  default     = 0
}

variable "repository_id" {
  type        = string
  description = "The ID of the Artifact Registry repository"
  default     = "frienda"
}
