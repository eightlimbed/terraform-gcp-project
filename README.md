### Terraform GCP Project
The goal of this project is to use Terraform to create a new Virtual Private
Cloud (VPC) in Google Cloud Platform (GCP) and provision a single instance
running NGINX.

##### Objectives
- Use Terraform to create a new VPC in GCP
- Use Terraform to provision a new VM Instance
    - The instance should be Internet accessible on ports 22, 80, and 443
    - Port 80 should redirect to port 443
    - Set up an SSL certificate using letsencrypt
    - Port 443 should serve some custom content

Live demo: [terralee.cf](https://terralee.cf)

##### Files
Name | Description
--- | ---
`app.yaml` | Configuration for an App Engine application
`main.go` | Go web application that show metadata about instances

##### TODO
- Use a configuration management tool to configure the instance after its
  provisioned
