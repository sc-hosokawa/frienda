terraform {
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

// ======= Network =======
resource "google_compute_network" "vpc_network" {
  name = "dev-network"
}

resource "google_vpc_access_connector" "connector" {
  name          = "dev-connector"
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.20.0.0/28"
  region        = var.region
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "dev-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.10.0.0"
  prefix_length = 16
  network       = google_compute_network.vpc_network.name
}

resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc_network.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

// ======= Cloud SQL =======
resource "google_sql_database_instance" "main" {
  project          = var.project_id
  name             = "frienda-dev-pg"
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier = "db-custom-1-3840"

    ip_configuration {
      private_network = google_compute_network.vpc_network.id
      ipv4_enabled    = false
    }
  }
}

resource "google_sql_database" "frienda_db" {
  project  = var.project_id
  name     = "frienda-pg"
  instance = google_sql_database_instance.main.name
}

resource "google_sql_user" "users" {
  project  = var.project_id
  name     = "frienda-pg"
  instance = google_sql_database_instance.main.name
  password = random_password.db_password.result
}

resource "random_password" "db_password" {
  length  = 16
  special = false
}

// ======= Cloud Run =======
resource "google_cloud_run_v2_service" "frienda_server" {
	name     = "frienda-server"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.frienda_server_image
      env {
        name  = "DATABASE_URL"
        value = "postgres://${google_sql_user.users.name}:${google_sql_user.users.password}@${google_sql_database_instance.main.private_ip_address}/${google_sql_database.frienda_db.name}"
      }
    }
    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress    = "ALL_TRAFFIC"
    }
  }
}

data "google_iam_policy" "no_auth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  location    = var.region
  name        = google_cloud_run_v2_service.frienda_server.name
  policy_data = data.google_iam_policy.no_auth.policy_data
}