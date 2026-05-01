output "frienda_server_url" {
  value = module.compute.cloud_run_uri
}

output "load_balancer_ip" {
  value = module.compute.load_balancer_ip
}

output "photo_storage_bucket_url" {
  value = module.storage.photo_bucket_name
}

output "general_file_storage_bucket_url" {
  value = module.storage.general_bucket_name
}
