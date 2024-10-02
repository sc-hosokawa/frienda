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
resource "google_cloud_run_service" "frienda_server" {
  name     = "frienda-server"
  location = var.region

  template {
    spec {
      containers {
        image = var.frienda_server_image
        env {
          name  = "DATABASE_URL"
          value = "postgres://${google_sql_user.default.name}:${google_sql_user.default.password}@/${google_sql_database.default.name}?host=/cloudsql/${google_sql_database_instance.instance.connection_name}"
        }
        resources {
          limits = {
            cpu    = "1000m"
            memory = "512Mi"
          }
        }
      }
      # サービスアカウントの指定を削除
      # service_account_name = google_service_account.frienda_server.email
    }

    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.instance.connection_name
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Cloud SQL Instance
resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier = "db-custom-1-3840"
    ip_configuration {
      ipv4_enabled    = false
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
  special = true
}

# Service Account for Cloud Run
resource "google_service_account" "frienda_server" {
  account_id   = "frienda-server-sa"
  display_name = "FRIENDA Server Service Account"
}

# Private VPC network
resource "google_compute_network" "private_network" {
  name = "private-network"
}

# IAMポリシーをデフォルトのサービスアカウントに適用
resource "google_project_iam_member" "default_account_cloudsql" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.project_id}@appspot.gserviceaccount.com"
}
