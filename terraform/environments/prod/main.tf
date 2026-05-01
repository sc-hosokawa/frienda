terraform {
  backend "gcs" {
    bucket  = "frienda-terraform-state"
    prefix  = "env/prod"
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
  network_name    = "frienda-network"
  connector_name  = "prod-connector"
  ip_cidr_range   = "10.20.0.0/28"
  private_ip_name = "prod-private-ip-alloc"
}

module "storage" {
  source = "../../modules/storage"

  project_id                = var.project_id
  region                    = var.region
  general_bucket_name       = "prd-frienda-general-files"
  state_bucket_name         = "frienda-terraform-state"
  sql_service_account_email = module.compute.sql_service_account_email_address
  enable_sql_iam_access     = true
}

module "compute" {
  source = "../../modules/compute"

  project_id               = var.project_id
  region                   = var.region
  environment              = "prod"
  network_id               = module.network.network_id
  connector_id             = module.network.connector_id
  security_policy_id       = module.network.security_policy_id
  lb_name                  = "frienda-prod-lb"
  db_instance_name         = "frienda-pg"
  run_service_name         = "frienda-server-core"
  frienda_server_image     = var.frienda_server_image
  frienda_server_image_tag = var.frienda_server_image_tag
  min_instance_count       = 1
  max_instance_count       = 10
  deletion_protection      = true
  backup_enabled           = true
  pitr_enabled             = true
}

// ======= Import Blocks (既存リソースの取り込み) =======

import {
  to = module.network.google_compute_network.vpc_network
  id = "projects/${var.project_id}/global/networks/frienda-network"
}

import {
  to = module.network.google_vpc_access_connector.connector
  id = "projects/${var.project_id}/locations/${var.region}/connectors/prod-connector"
}

import {
  to = module.network.google_compute_global_address.private_ip_address
  id = "projects/${var.project_id}/global/addresses/prod-private-ip-alloc"
}

import {
  to = module.compute.google_sql_database_instance.main
  id = "${var.project_id}/frienda-pg"
}

import {
  to = module.compute.google_sql_database.frienda_db
  id = "${var.project_id}/frienda-pg/frienda-pg"
}

import {
  to = module.compute.google_sql_user.users
  id = "${var.project_id}/frienda-pg/frienda-pg"
}

import {
  to = module.compute.google_cloud_run_v2_service.frienda_server
  id = "projects/${var.project_id}/locations/${var.region}/services/frienda-server-core"
}

import {
  to = module.storage.google_storage_bucket.general_file_storage
  id = "prd-frienda-general-files"
}

import {
  to = module.storage.google_storage_bucket.state_storage[0]
  id = "frienda-terraform-state"
}
