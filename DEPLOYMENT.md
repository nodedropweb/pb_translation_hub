# Deployment Guide: PB Translation Hub

This guide explains how to deploy the PB Translation Hub on a production Linux server (Debian, Ubuntu, or Fedora).

## 1. Prerequisites

- **Node.js**: Version 18.x or higher (v20+ recommended)
- **NPM**: Version 9.x or higher
- **Web Server**: Nginx or Apache2
- **Persistence**: Ensure the `server/data` directory is on a persistent volume.

---

## 2. Server Preparation

### Debian / Ubuntu
```bash
sudo apt update
sudo apt install -y nodejs npm git nginx
```

### Fedora
```bash
sudo dnf install -y nodejs npm git nginx
```

---

## 3. Installation

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url> /var/www/pb-translation-hub
   cd /var/www/pb-translation-hub
   ```

2. **Backend Setup**:
   ```bash
   cd server
   npm install
   ```

3. **Frontend Production Build**:
   ```bash
   cd ../client
   npm install
   # Create a .env file for the frontend build if your production URL is different
   echo "VITE_API_BASE=/api" > .env.production
   npm run build
   ```

---

## 4. Process Management (Systemd)

Create a service file to keep the backend running and auto-restart on failure.

**File**: `/etc/systemd/system/pb-hub-backend.service`

```ini
[Unit]
Description=PB Translation Hub Backend
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/var/www/pb-translation-hub/server
ExecStart=/usr/bin/node index.js
Restart=on-failure
Environment=PORT=3001
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```

**Enable and Start**:
```bash
sudo systemctl daemon-reload
sudo systemctl enable pb-hub-backend
sudo systemctl start pb-hub-backend
```

---

## 5. Web Server Configuration (Reverse Proxy)

### Option A: Nginx (Recommended)

**File**: `/etc/nginx/sites-available/pb-hub`

```nginx
server {
    listen 80;
    server_name your-hub-domain.com;

    # Frontend Static Files
    root /var/www/pb-translation-hub/client/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Backend API Proxy
    location /api {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # Direct access for Drupal PB Localizer (e.g. /de/admin_toolbar.json)
    location ~ ^/(de|en|fr|es|it)/.+\.json$ {
        proxy_pass http://localhost:3001;
        proxy_set_header Host $host;
    }
}
```

### Option B: Apache2

**Enable modules**:
```bash
sudo a2enmod proxy proxy_http rewrite
```

**File**: `/etc/apache2/sites-available/pb-hub.conf`

```apache
<VirtualHost *:80>
    ServerName your-hub-domain.com
    DocumentRoot /var/www/pb-translation-hub/client/dist

    <Directory /var/www/pb-translation-hub/client/dist>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        
        # SPA Routing
        RewriteEngine On
        RewriteBase /
        RewriteRule ^index\.html$ - [L]
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule . /index.html [L]
    </Directory>

    # Backend Proxy
    ProxyPreserveHost On
    ProxyPass /api http://localhost:3001/api
    ProxyPassReverse /api http://localhost:3001/api

    # Drupal Module Access
    ProxyPassMatch "^/(de|en|fr|es|it)/(.+)$" "http://localhost:3001/$1/$2"
</VirtualHost>
```

---

## 6. Security Hardening

1. **Firewall**: Ensure only ports 80/443 are open to the public. Port 3001 should remain local.
2. **SSL**: Use Certbot for Let's Encrypt:
   ```bash
   sudo apt install certbot python3-certbot-nginx
   sudo certbot --nginx -d your-hub-domain.com
   ```

## 7. Configuration for Drupal

Once the hub is live, connect your Drupal sites via Drush:
```bash
drush config:set pb_localizer.settings translation_mirror_url "https://your-hub-domain.com" --yes
```
