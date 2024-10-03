output "cloud_run_service_url" {
  value       = google_cloud_run_v2_service.frienda_server.uri
  description = "URL of the Cloud Run service"
}

output "cloud_sql_instance_connection_name" {
  value       = google_sql_database_instance.instance.connection_name
  description = "Connection name of the Cloud SQL instance"
}
