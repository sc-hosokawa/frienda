resource "random_password" "db_password" {
  count   = var.db_password == "" ? 1 : 0
  length  = 16
  special = false
}

locals {
  actual_db_password = var.db_password == "" ? random_password.db_password[0].result : var.db_password
}

// ======= Cloud SQL =======
resource "google_sql_database_instance" "main" {
  project          = var.project_id
  name             = var.db_instance_name
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier = var.db_tier

    ip_configuration {
      private_network = var.network_id
      ipv4_enabled    = false
    }

    backup_configuration {
      enabled                        = var.backup_enabled
      point_in_time_recovery_enabled = var.pitr_enabled
      start_time                     = "02:00" // UTC
    }
  }
  deletion_protection = var.deletion_protection
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
  password = local.actual_db_password
}

// ======= Cloud Run =======
resource "google_cloud_run_v2_service" "frienda_server" {
  name     = var.run_service_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"

  template {
    containers {
      image = "${var.frienda_server_image}:${var.frienda_server_image_tag}"
      env {
        name  = "DATABASE_URL"
        value = "postgres://${google_sql_user.users.name}:${google_sql_user.users.password}@${google_sql_database_instance.main.private_ip_address}/${google_sql_database.frienda_db.name}"
      }
    }
    vpc_access {
      connector = var.connector_id
      egress    = "PRIVATE_RANGES_ONLY"
    }
    scaling {
      min_instance_count = var.min_instance_count
      max_instance_count = var.max_instance_count
    }
  }
  lifecycle {
    ignore_changes        = [template[0].containers[0]]
    create_before_destroy = true
  }
}

// ======= Load Balancer (Serverless GCLB) =======
resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = "${var.run_service_name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_v2_service.frienda_server.name
  }
}

resource "google_compute_backend_service" "default" {
  name                  = "${var.lb_name}-backend"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  security_policy       = var.security_policy_id

  backend {
    group = google_compute_region_network_endpoint_group.serverless_neg.id
  }
}

resource "google_compute_url_map" "default" {
  name            = "${var.lb_name}-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.lb_name}-http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_address" "lb_ip" {
  name = "${var.lb_name}-ip"
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.lb_name}-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.lb_ip.id
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
