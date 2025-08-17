docker run -d --restart unless-stopped \
--name n8n \
-p 5678:5678 \
-e WEBHOOK_URL="https://YOURDOMAIN.COM/" \
-e N8N_HOST="YOURDOMAIN.COM" \
-e N8N_PROTOCOL=https \
-e N8N_WEBHOOK_URL="https://YOURDOMAIN.COM" \
-v n8n_data:/home/node/.n8n \
docker.n8n.io/n8nio/n8n
