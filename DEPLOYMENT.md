# Deployment Guide: PB Translation Hub

This guide explains how to deploy the PB Translation Hub on a production Linux server using Docker.

## 1. Prerequisites

- **Node.js**: Version 18.x or higher (v20+ recommended)
- **NPM**: Version 9.x or higher
- **Docker**: Version 24+ with **Docker Compose**
- **SSH Access**: To the target production server
- **Unsplash API Key**: Required for background imagery and photographer attribution.

---

## 2. Docker Deployment (Recommended)

This is the fastest and most reliable way to deploy the Hub.

### Step 1: Initial Sync & Prep
Synchronize your local codebase to the server using `rsync`. This preserves your existing database and volumes on the server while updating the code.

```bash
# Run this from your local machine
rsync -avz --progress \
  --exclude 'node_modules' \
  --exclude '.git' \
  --exclude 'server/data' \
  --exclude 'server/uploads' \
  --exclude 'client/node_modules' \
  ./ user@your-server.com:/path/to/app/
```

### Step 2: Environment Configuration
Ensure you have a `.env` file in the `server/` directory on the remote host. The `docker-compose.yml` is configured to load this file automatically.

**Required `.env` variables**:
- `UNSPLASH_ACCESS_KEY`, `UNSPLASH_SECRET_KEY`
- `DB_USER`, `DB_PASSWORD`, `DB_NAME`
- `JWT_SECRET`

### Step 3: Start the Containers
SSH into your server and start the application:

```bash
ssh user@your-server.com "cd /path/to/app && docker compose build && docker compose up -d"
```

---

## 3. Web Server Configuration (Nginx Reverse Proxy)

When using Docker, the frontend is served on port `5173`. Configure Nginx to proxy requests to the container:

```nginx
server {
    listen 80;
    server_name your-hub-domain.com;

    location / {
        proxy_pass http://localhost:5173;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Ensure large uploads (avatars) are allowed
    client_max_body_size 10M;
}
```

---

## 4. Troubleshooting

### Unsplash API not working?
Check the server logs to see the exact error:
```bash
docker compose logs server | tail -n 50
```
Common issues include incorrect `UNSPLASH_ACCESS_KEY` or reaching the Sandbox rate limit (50 req/hr).

### Avatars not persisting?
Ensure the volume mount for `/app/uploads` is correctly defined in `docker-compose.yml`.

---

## 5. Connecting Drupal to the Hub
Once the hub is live, connect your Drupal sites via Drush:
```bash
drush config:set pb_localizer.settings translation_mirror_url "https://your-hub-domain.com" --yes
```
