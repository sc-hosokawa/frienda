output "cloud_run_service_url" {
  value       = google_cloud_run_v2_service.frienda_server.uri
  description = "URL of the Cloud Run service"
}