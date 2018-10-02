//
// main.tf -- Contains the infrastructure configuration that will be created.
// Variables can be found in vars.tf
//

// Configure GCP
provider "google" {
    version     = "~> 1.18"
    credentials = "${file("${var.credentials}")}"
    project     = "${var.gcp_project}"
    region      = "${var.gcp_region}"
}

// Create VPC
resource "google_compute_network" "vpc" {
    name                    = "${var.name}-vpc"
    auto_create_subnetworks = "false" // Manually create Subnet (see below)
}

// Create Subnet
resource "google_compute_subnetwork" "subnet" {
    name          = "${var.name}-subnet"
    ip_cidr_range = "${var.subnet_cidr}"
    network       = "${var.name}-vpc"
    depends_on    = ["google_compute_network.vpc"]
    region        = "${var.gcp_region}"
}

// VPC Firewall Configuration
resource "google_compute_firewall" "firewall" {
    name = "${var.name}-firewall"
    network = "${google_compute_network.vpc.name}"

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
}
