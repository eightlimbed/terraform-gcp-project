# This script can be used to configure a standard VM Instance on GCP to be an
# nginx reverse proxy with a letsencrypt cert that serves over port 443.

if [ "$#" -ne 1 ]; then
    echo "USAGE: ./revproxy-init.sh DOMAIN_NAME"
    exit 1
fi

DOMAIN=$1

# Install and enable nginx
sudo apt-get update && sudo apt-get install -y nginx
sudo systemctl enable nginx

# Install Certbot
echo "deb http://deb.debian.org/debian stretch-backports main contrib non-free
deb-src http://deb.debian.org/debian stretch-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list

sudo apt update
sudo apt install -y python-certbot-nginx -t stretch-backports

# NGINX Configuration
sudo mkdir -p /var/www/$DOMAIN/html
sudo chown -R $USER:$USER /var/www/$DOMAIN/html
sudo chmod -R 755 /var/www/$DOMAIN
echo "nginx works" | sudo tee /var/www/$DOMAIN/html/index.html
echo "server {
        listen 80;
        listen [::]:80;

        root /var/www/$DOMAIN/html;
        index index.html index.htm index.nginx-debian.html;

        server_name $DOMAIN www.$DOMAIN;

        location / {
                try_files \$uri \$uri/ =404;
        }
}" | sudo tee /etc/nginx/sites-available/$DOMAIN
sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled
sudo sed -in 's/\s# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/' /etc/nginx/nginx.conf

sudo systemctl restart nginx

# Certbot Configuration
sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN
# And this is where a human needs to take over...
