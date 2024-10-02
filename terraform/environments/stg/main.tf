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
      }
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
  database_version = "POSTGRES_16"

  settings {
    tier = "db-f1-micro"
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
  password = var.db_password
}
