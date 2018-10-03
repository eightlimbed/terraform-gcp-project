### Terraform GCP Project
The goal of this project is to use Google Cloud Platform (GCP) and Terraform to
create and codify infrastructure for a simple web application. The
infrastructure includes:
- Networking (VPC, subnet, firewalls)
- NGINX instance (reverse proxy)
- App Engine web application (load-balanced with 3 replicas)

![screenshot](https://storage.googleapis.com/terraform-nginx-app.appspot.com/lb.gif)

##### URL
Access the web app here: [hellpgcp.cf](https://hellogcp.cf/)

##### Architecture
```
Internet --> NGINX reverse proxy --> Load-balanced App Engine app (3 instances)
```

##### Repo Structure
Dir/File | Description
--- | ---
`app/` | Contains the Go web application and App Engine config
`network/` | Contains codified infrastructure to set up VPC, subnet and firewall
`reverse-proxy/` | Contains codified infrastructure to set up a VM instance
`reverse-proxy/init.sh` | Bash script to configure VM instance with NGINX and
Certbot
