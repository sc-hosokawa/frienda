terraform {
  backend "gcs" {
    bucket = "prd-frienda-terraform-state"
    prefix = "env/test"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.8.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "../../modules/network"

  project_id      = var.project_id
  region          = var.region
  network_name    = "test-network"
  connector_name  = "test-connector"
  ip_cidr_range   = "10.20.0.0/28"
  private_ip_name = "test-private-ip-alloc"
}

module "storage" {
  source = "../../modules/storage"

  project_id                = var.project_id
  region                    = var.region
  general_bucket_name       = "test-frienda-general-files"
  delete_after_days         = 30
  force_destroy             = true
  sql_service_account_email = module.compute.sql_service_account_email_address
  enable_sql_iam_access     = true
}

module "compute" {
  source = "../../modules/compute"

  project_id               = var.project_id
  region                   = var.region
  environment              = "test"
  network_id               = module.network.network_id
  connector_id             = module.network.connector_id
  db_instance_name         = "frienda-test-pg"
  db_tier                  = "db-f1-micro"
  db_password              = var.db_password
  run_service_name         = "frienda-test-server"
  frienda_server_image     = var.frienda_server_image
  frienda_server_image_tag = var.frienda_server_image_tag
  max_instance_count       = 2
  deletion_protection      = false
}

// ======= State Migration (moved blocks) =======
moved {
  from = google_compute_network.vpc_network
  to   = module.network.google_compute_network.vpc_network
}

moved {
  from = google_vpc_access_connector.connector
  to   = module.network.google_vpc_access_connector.connector
}

moved {
  from = google_compute_global_address.private_ip_address
  to   = module.network.google_compute_global_address.private_ip_address
}

moved {
  from = google_service_networking_connection.default
  to   = module.network.google_service_networking_connection.default
}

moved {
  from = google_sql_database_instance.main
  to   = module.compute.google_sql_database_instance.main
}

moved {
  from = google_sql_database.frienda_db
  to   = module.compute.google_sql_database.frienda_db
}

moved {
  from = google_sql_user.users
  to   = module.compute.google_sql_user.users
}

moved {
  from = google_cloud_run_v2_service.frienda_server
  to   = module.compute.google_cloud_run_v2_service.frienda_server
}

moved {
  from = google_cloud_run_v2_service_iam_policy.policy
  to   = module.compute.google_cloud_run_v2_service_iam_policy.policy
}

moved {
  from = google_storage_bucket.general_file_storage
  to   = module.storage.google_storage_bucket.general_file_storage
}

moved {
  from = google_storage_bucket_iam_member.sql_storage_object_admin
  to   = module.storage.google_storage_bucket_iam_member.sql_storage_object_admin[0]
}

// ======= Import existing resources =======
import {
  to = module.storage.google_artifact_registry_repository.registry
  id = "projects/${var.project_id}/locations/${var.region}/repositories/frienda"
}
