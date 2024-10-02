output "cloud_run_service_url" {
  value       = google_cloud_run_service.frienda_server.status[0].url
  description = "URL of the Cloud Run service"
}