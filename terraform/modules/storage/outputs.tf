output "general_bucket_name" {
  value = google_storage_bucket.general_file_storage.name
}

output "photo_bucket_name" {
  value = var.photo_bucket_name != "" ? google_storage_bucket.photo_storage[0].name : null
}

output "state_bucket_name" {
  value = var.state_bucket_name != "" ? google_storage_bucket.state_storage[0].name : null
}

/*
output "repository_name" {
  value = google_artifact_registry_repository.registry.name
}
*/
