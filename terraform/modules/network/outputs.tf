output "network_name" {
  value = google_compute_network.vpc_network.name
}

output "network_id" {
  value = google_compute_network.vpc_network.id
}

output "connector_id" {
  value = google_vpc_access_connector.connector.id
}

output "private_network_id" {
  value = google_compute_network.vpc_network.id
}

output "security_policy_id" {
  value = google_compute_security_policy.policy.id
}
