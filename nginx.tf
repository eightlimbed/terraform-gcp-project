//
// nginx.tf: Configuration for a GCP VM Instance running nginx
//

// Configure GCP
provider "google" {
    version     = "~> 1.18"
    credentials = "${file("${var.credentials}")}"
    project     = "${var.gcp_project}"
    region      = "${var.gcp_region}"
}

// VM Instance Configuration
resource "google_compute_instance" "nginx" {
    name         = "nginx"
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
