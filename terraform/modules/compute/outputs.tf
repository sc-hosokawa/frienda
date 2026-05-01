output "sql_instance_name" {
  value = google_sql_database_instance.main.name
}

output "sql_service_account_email_address" {
  value = google_sql_database_instance.main.service_account_email_address
}

output "cloud_run_uri" {
  value = google_cloud_run_v2_service.frienda_server.uri
}

output "db_password" {
  value     = local.actual_db_password
  sensitive = true
}

output "load_balancer_ip" {
  value = google_compute_global_address.lb_ip.address
}
