//
// vars.tf -- Contains variables that are used in main.tf
//

variable "credentials" { default = "credentials.json" }
variable "gcp_project" { default = "terraform-nginx-app" }
variable "name"        { default = "dev" }
variable "region"      { default = "us-west1" }
variable "subnet_cidr" { default = "10.10.0.0/24" }
