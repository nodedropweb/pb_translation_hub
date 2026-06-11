FROM node:22-alpine
WORKDIR /app

# Install dependencies first (caching layer)
COPY package*.json ./
RUN npm install --production

# Install PM2
RUN npm install -g pm2

# Copy source
COPY . .

# Ensure data directory exists
RUN mkdir -p data

EXPOSE 9901

# Single instance — sync state is in-memory; cluster mode would cause concurrent syncs
CMD ["pm2-runtime", "index.js", "-i", "1"]
