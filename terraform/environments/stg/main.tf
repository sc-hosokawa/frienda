terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Cloud Run Service
resource "google_cloud_run_v2_service" "frienda_server" {
  name     = "frienda-server"
  location = var.region

  template {
		scaling {
			max_instance_count = 2
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.instance.connection_name]
      }
    }

    containers {
      image = var.frienda_server_image
      env {
        name  = "DATABASE_URL"
        value = "postgres://${google_sql_user.default.name}:${google_sql_user.default.password}@/cloudsql/${google_sql_database_instance.instance.connection_name}/${google_sql_database.default.name}"
      }
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  # データベースインスタンス、データベース、ユーザーが作成された後にCloud Runサービスを作成
  depends_on = [
    google_sql_database_instance.instance,
    google_sql_database.default,
    google_sql_user.default
  ]
}

# Cloud SQL Instance
resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = var.region
  database_version = "POSTGRES_16"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-perf-optimized-N-2"
    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.private_network.id
    }
    backup_configuration {
      enabled = true
    }
  }

  deletion_protection = false
}

# Database
resource "google_sql_database" "default" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

# Database User
resource "google_sql_user" "default" {
  name     = "my-user"
  instance = google_sql_database_instance.instance.name
  password = random_password.db_password.result
}

# Generate random password for database
resource "random_password" "db_password" {
  length  = 16
  special = false
}

# Service Account for Cloud Run
resource "google_service_account" "frienda_server" {
  account_id   = "frienda-server-sa"
  display_name = "FRIENDA Server Service Account"
}

# Private VPC network
resource "google_compute_network" "private_network" {
  name                    = "private-network"
  auto_create_subnetworks = false
}

# VPCに対するサブネットの作成
resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.private_network.id
}

# Service Networking接続の設定
resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# IAMポリシーをCloud Run用のサービスアカウントに適用
resource "google_project_iam_member" "frienda_server_cloudsql" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.frienda_server.email}"
}

# Cloud Run Invokerの権限を追加
resource "google_project_iam_member" "frienda_server_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.frienda_server.email}"
}

# サービスアカウントをCloud Runサービスに関連付け
resource "google_cloud_run_service_iam_member" "frienda_server_sa_binding" {
  location = google_cloud_run_v2_service.frienda_server.location
  service  = google_cloud_run_v2_service.frienda_server.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.frienda_server.email}"
}
