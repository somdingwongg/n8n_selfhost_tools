````markdown
# n8n Docker Deployment & Update Scripts

This repository contains two scripts to help you quickly **deploy** and **update** an `n8n` instance using Docker.

---

## 🚀 Deployment Script

The following command runs an `n8n` container with persistent storage and automatic restart enabled. Before running, replace `YOURDOMAIN.COM` with your actual domain.

```bash
docker run -d --restart unless-stopped \
--name n8n \
-p 5678:5678 \
-e WEBHOOK_URL="https://YOURDOMAIN.COM/" \
-e N8N_HOST="YOURDOMAIN.COM" \
-e N8N_PROTOCOL=https \
-e N8N_WEBHOOK_URL="https://YOURDOMAIN.COM" \
-v n8n_data:/home/node/.n8n \
docker.n8n.io/n8nio/n8n
````

### Key Flags & Variables

  - `-d` → Runs the container in detached mode.
  - `--restart unless-stopped` → Ensures n8n auto-restarts unless manually stopped.
  - `--name n8n` → Names the container `n8n` for easy reference.
  - `-p 5678:5678` → Maps port `5678` on your local machine to port `5678` inside the container.
  - `-e WEBHOOK_URL` → The full webhook URL (e.g., `https://YOURDOMAIN.COM/`).
  - `-e N8N_HOST` → The domain where n8n is hosted.
  - `-e N8N_PROTOCOL` → Should be `https` in production environments.
  - `-e N8N_WEBHOOK_URL` → Used for external webhook handling.
  - `-v n8n_data:/home/node/.n8n` → Creates a persistent Docker volume named `n8n_data` to store your workflows and credentials.
  - `docker.n8n.io/n8nio/n8n` → The official n8n Docker image.

-----

## 🔄 Update Script

To update your n8n instance to the latest version, follow these steps. This process pulls the newest image, stops and removes the old container, and then starts a new one using the updated image and your existing data.

**1. Pull the latest n8n image:**

```bash
docker pull docker.n8n.io/n8nio/n8n
```

**2. Stop and remove the existing container:**

```bash
docker stop n8n && docker rm n8n
```

**3. Re-run the deployment script:**
Execute the same `docker run` command you used for the initial deployment. Docker will automatically use the newly pulled image.

```bash
docker run -d --restart unless-stopped \
--name n8n \
-p 5678:5678 \
-e WEBHOOK_URL="https://YOURDOMAIN.COM/" \
-e N8N_HOST="YOURDOMAIN.COM" \
-e N8N_PROTOCOL=https \
-e N8N_WEBHOOK_URL="https://YOURDOMAIN.COM" \
-v n8n_data:/home/node/.n8n \
docker.n8n.io/n8nio/n8n
```

-----

## 📂 Data Persistence

All workflows, credentials, and settings are stored in the `n8n_data` Docker volume. This ensures your data is safe and is not lost when updating or restarting the container.

## ⚠️ Notes

  - Remember to replace `YOURDOMAIN.COM` with your actual domain in the deployment commands.
  - If you are running this behind a reverse proxy, ensure it is configured correctly to forward requests to `http://localhost:5678`.
