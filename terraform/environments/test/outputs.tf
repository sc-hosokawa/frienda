output "cloud_run_url" {
  value = google_cloud_run_v2_service.frienda_server.uri
}

output "db_instance_private_ip" {
  value = google_sql_database_instance.main.private_ip_address
}

output "jump_host_name" {
  value = google_compute_instance.db_jump_host.name
}

output "jump_host_ssh_command" {
  value     = "gcloud compute ssh ${google_compute_instance.db_jump_host.name} --tunnel-through-iap --zone ${google_compute_instance.db_jump_host.zone} --project ${var.project_id}"
  sensitive = true
}

output "psql_connect_command" {
  value     = "psql -h ${google_sql_database_instance.main.private_ip_address} -U ${google_sql_user.users.name} -d ${google_sql_database.frienda_db.name}"
  sensitive = true
}
