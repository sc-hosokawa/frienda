terraform {
  backend "gcs" {
    bucket  = "frienda-terraform-state"
    prefix  = "env/dev"
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
  network_name    = "dev-network"
  connector_name  = "dev-connector"
  ip_cidr_range   = "10.20.0.0/28"
  private_ip_name = "dev-private-ip-alloc"
}

module "storage" {
  source = "../../modules/storage"

  project_id                = var.project_id
  region                    = var.region
  general_bucket_name       = "frienda-general-files"
  photo_bucket_name         = "frienda-photo-storage"
  state_bucket_name         = "frienda-terraform-state"
  sql_service_account_email = module.compute.sql_service_account_email_address
  enable_sql_iam_access     = true
}

module "compute" {
  source = "../../modules/compute"

  project_id               = var.project_id
  region                   = var.region
  environment              = "dev"
  network_id               = module.network.network_id
  connector_id             = module.network.connector_id
  security_policy_id       = module.network.security_policy_id
  lb_name                  = "frienda-dev-lb"
  db_instance_name         = "frienda-dev-pg"
  db_password              = var.db_password
  run_service_name         = "frienda-server"
  frienda_server_image     = var.frienda_server_image
  frienda_server_image_tag = var.frienda_server_image_tag
  deletion_protection      = false
}

// ======= Import Blocks (既存リソースの取り込み) =======

import {
  to = module.network.google_compute_network.vpc_network
  id = "projects/${var.project_id}/global/networks/dev-network"
}

import {
  to = module.network.google_vpc_access_connector.connector
  id = "projects/${var.project_id}/locations/${var.region}/connectors/dev-connector"
}

import {
  to = module.network.google_compute_global_address.private_ip_address
  id = "projects/${var.project_id}/global/addresses/dev-private-ip-alloc"
}

import {
  to = module.compute.google_sql_database_instance.main
  id = "${var.project_id}/frienda-dev-pg"
}

import {
  to = module.compute.google_sql_database.frienda_db
  id = "${var.project_id}/frienda-dev-pg/frienda-pg"
}

import {
  to = module.compute.google_sql_user.users
  id = "${var.project_id}/frienda-dev-pg/frienda-pg"
}

import {
  to = module.compute.google_cloud_run_v2_service.frienda_server
  id = "projects/${var.project_id}/locations/${var.region}/services/frienda-server"
}

import {
  to = module.storage.google_storage_bucket.general_file_storage
  id = "frienda-general-files"
}

import {
  to = module.storage.google_storage_bucket.photo_storage[0]
  id = "frienda-photo-storage"
}

import {
  to = module.storage.google_storage_bucket.state_storage[0]
  id = "frienda-terraform-state"
}
