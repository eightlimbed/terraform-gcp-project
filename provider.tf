//
// provider.tf: Configuration for GCP
///

provider "google" {
    version     = "~> 1.18"
    credentials = "${file("${var.credentials}")}"
    project     = "${var.gcp_project}"
    region      = "${var.gcp_region}"
}

