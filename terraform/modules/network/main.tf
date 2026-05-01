resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

resource "google_vpc_access_connector" "connector" {
  name          = var.connector_name
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
}

resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_ip_name
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

// ======= Cloud Armor Security Policy =======
resource "google_compute_security_policy" "policy" {
  name        = "${var.network_name}-security-policy"
  description = "Basic security policy for ${var.network_name}"

  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
      }
    }
    description = "SQL Injection protection"
  }

  rule {
    action   = "deny(403)"
    priority = "1001"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-v33-stable')"
      }
    }
    description = "XSS protection"
  }

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default rule"
  }
}
