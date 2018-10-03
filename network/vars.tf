//
// vars.tf -- Contains variables that are used in the other .tf config files
//

variable "credentials" { default = "credentials.json" }
variable "gcp_project" { default = "terraform-nginx-app" }
variable "name"        { default = "dev" }
variable "gcp_region"  { default = "us-west1" }
variable "gcp_zone"    { default = "us-west1-a" }
variable "subnet_cidr" { default = "10.10.0.0/24" }
