#!/bin/bash

# Load environment variables
set -a
source .env
set +a

DOMAIN=$1
IP=$2  # e.g. 172.31.12.167 (local container IP)

if [[ -z "$DOMAIN" || -z "$IP" ]]; then
  echo "Usage: ./add-client.sh <domain.com> <container-ip>"
  exit 1
fi

echo "[+] Adding domain $DOMAIN with IP $IP"

# ---------------------
# 1. Create zone in PowerDNS DB (MariaDB)
# ---------------------

# Use correct host, user, and password
mysql -h "$PDNS_DB_HOST" -u "$PDNS_DB_USER" -p"$PDNS_DB_PASS" "$PDNS_DB_NAME" -e "
INSERT IGNORE INTO domains (name, type) VALUES ('$DOMAIN', 'MASTER');
"

mysql -h "$PDNS_DB_HOST" -u "$PDNS_DB_USER" -p"$PDNS_DB_PASS" "$PDNS_DB_NAME" -e "
INSERT INTO records (domain_id, name, type, content, ttl, prio) 
VALUES
  ((SELECT id FROM domains WHERE name = '$DOMAIN'), '$DOMAIN', 'A', '$IP', 3600, NULL),
  ((SELECT id FROM domains WHERE name = '$DOMAIN'), '$DOMAIN', 'NS', 'ns1.raool.site.', 3600, NULL),
  ((SELECT id FROM domains WHERE name = '$DOMAIN'), '$DOMAIN', 'NS', 'ns2.raool.site.', 3600, NULL);
"

echo "[+] DNS records added for $DOMAIN"

# ---------------------
# 2. Create website directory
# ---------------------
mkdir -p /var/www/$DOMAIN
echo "<h1>Welcome to $DOMAIN</h1>" > /var/www/$DOMAIN/index.html

# ---------------------
# 3. Launch Docker container
# ---------------------
if docker ps -a --format '{{.Names}}' | grep -q "^$DOMAIN$"; then
  echo "[i] Docker container $DOMAIN already exists. Restarting it..."
  docker restart "$DOMAIN"
else
  docker run -d --name $DOMAIN -v /var/www/$DOMAIN:/usr/share/nginx/html -p 0:80 nginx
fi

# Get container IP
CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $DOMAIN)
echo "[+] Docker container running at IP: $CONTAINER_IP"

# ---------------------
# 4. Configure NGINX reverse proxy
# ---------------------
NGINX_CONF="/etc/nginx/sites-available/$DOMAIN.conf"

cat <<EOF > $NGINX_CONF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://$IP;
    }
}
EOF

if [ ! -f /etc/nginx/sites-enabled/$DOMAIN.conf ]; then
  ln -s $NGINX_CONF /etc/nginx/sites-enabled/
else
  echo "[i] NGINX symlink already exists for $DOMAIN, skipping..."
fi

nginx -t && systemctl reload nginx
echo "[+] NGINX proxy set up for $DOMAIN → $IP"
