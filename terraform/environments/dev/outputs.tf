output "frienda_server_url" {
  value = google_cloud_run_v2_service.frienda_server.uri
}

output "photo_storage_bucket_url" {
  value = google_storage_bucket.photo_storage.url
}

output "general_file_storage_bucket_url" {
  value = google_storage_bucket.general_file_storage.url
}
