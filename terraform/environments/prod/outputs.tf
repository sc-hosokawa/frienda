output "frienda_server_url" {
  value = module.compute.cloud_run_uri
}

output "load_balancer_ip" {
  value = module.compute.load_balancer_ip
}

output "general_file_storage_bucket_url" {
  value = module.storage.general_bucket_name
}
