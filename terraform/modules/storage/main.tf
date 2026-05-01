resource "google_storage_bucket" "general_file_storage" {
  name          = var.general_bucket_name
  location      = var.region
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  force_destroy               = var.force_destroy

  versioning {
    enabled = true
  }

  dynamic "lifecycle_rule" {
    for_each = var.delete_after_days > 0 ? [1] : []
    content {
      condition {
        age = var.delete_after_days
      }
      action {
        type = "Delete"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.delete_after_days == 0 ? [1] : []
    content {
      condition {
        age = 30
      }
      action {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
    }
  }
}

resource "google_storage_bucket" "photo_storage" {
  count         = var.photo_bucket_name != "" ? 1 : 0
  name          = var.photo_bucket_name
  location      = var.region
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  force_destroy               = var.force_destroy

  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }
}

resource "google_storage_bucket" "state_storage" {
  count         = var.state_bucket_name != "" ? 1 : 0
  name          = var.state_bucket_name
  location      = "us-west1"
  storage_class = "REGIONAL"

  public_access_prevention = "enforced"
  force_destroy            = var.force_destroy

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
    }
  }
}

resource "google_storage_bucket_iam_member" "sql_storage_object_admin" {
  count  = var.enable_sql_iam_access ? 1 : 0
  bucket = google_storage_bucket.general_file_storage.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.sql_service_account_email}"
}

/*
// ======= Artifact Registry =======
resource "google_artifact_registry_repository" "registry" {
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker repository for FRIENDA"
  format        = "DOCKER"
}
*/
