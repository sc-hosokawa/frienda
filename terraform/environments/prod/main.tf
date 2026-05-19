terraform {
  cloud {
    organization = "scratch-jp"
    workspaces {
      name = "frienda-prod"
    }
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

// ======= Network =======
resource "google_compute_network" "vpc_network" {
  name = "frienda-network"
}

resource "google_vpc_access_connector" "connector" {
  name          = "prod-connector"
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.20.0.0/28"
  region        = var.region
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "prod-private-ip-alloc"
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
  name             = "frienda-pg"
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier = "db-custom-1-3840"

    ip_configuration {
      private_network = google_compute_network.vpc_network.id
      ipv4_enabled    = false
    }

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
      start_time                     = "02:00" // UTC
    }
  }
  deletion_protection = true
  depends_on          = [google_service_networking_connection.default]
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

resource "google_storage_bucket_iam_member" "sql_storage_object_admin" {
  bucket = google_storage_bucket.general_file_storage.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_sql_database_instance.main.service_account_email_address}"
}

// ======= Cloud Run =======
resource "google_cloud_run_v2_service" "frienda_server" {
  name     = "frienda-server-core"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "${var.frienda_server_image}:${var.frienda_server_image_tag}"
      env {
        name  = "DATABASE_URL"
        value = "postgres://${google_sql_user.users.name}:${google_sql_user.users.password}@${google_sql_database_instance.main.private_ip_address}/${google_sql_database.frienda_db.name}"
      }
      env {
        name  = "JWK_URL"
        value = "https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com"
      }
      env {
        name  = "JWK_ISSUER"
        value = "https://securetoken.google.com/friendship-dao"
      }
      env {
        name  = "JWK_AUDIENCE"
        value = "friendship-dao"
      }
    }
    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress    = "PRIVATE_RANGES_ONLY"
    }
    scaling {
      min_instance_count = 1
      max_instance_count = 10
    }
  }
  lifecycle {
    ignore_changes        = [template[0].containers[0]]
    create_before_destroy = true
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

// ======= Object Storage =======
resource "google_storage_bucket" "terraform-state-store" {
  name          = "prd-frienda-terraform-state"
  location      = "us-west1"
  storage_class = "REGIONAL"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
    }
  }
}

resource "google_storage_bucket" "general_file_storage" {
  name          = "prd-frienda-general-files"
  location      = var.region
  storage_class = "STANDARD"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }
}
