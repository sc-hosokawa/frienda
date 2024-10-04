output "frienda_server_url" {
  value = google_cloud_run_v2_service.frienda_server.status[0].url
}
