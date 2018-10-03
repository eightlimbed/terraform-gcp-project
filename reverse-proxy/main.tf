//
// main.tf: Configuration for a GCP VM Instance running nginx
//

// GCP Configuration
provider "google" {
    version     = "~> 1.18"
    credentials = "${file("${var.credentials}")}"
    project     = "${var.gcp_project}"
    region      = "${var.gcp_region}"
}

// VM Instance Configuration
resource "google_compute_instance" "default" {
    name         = "default"
    machine_type = "n1-standard-1"
    zone         = "${var.gcp_zone}"

    network_interface {
        network = "default"
        access_config {
            // Ephemeral external IP address
        }
    }

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }
}

// Firewall Rules to open ports 22, 80, 443 over TCP
resource "google_compute_firewall" "nginx_firewall" {
    name = "nginx-firewall"
    network = "default"

    allow {
        protocol = "tcp"
        ports    = ["22", "80", "443"]
    }
}
