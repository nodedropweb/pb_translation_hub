FROM node:22-alpine
WORKDIR /app

# Install dependencies first (caching layer)
COPY package*.json ./
RUN npm install --production

# Install PM2 for cluster mode (Performance benefit!)
RUN npm install -g pm2

# Copy source
COPY . .

# Ensure data directory exists
RUN mkdir -p data

EXPOSE 9901

# Start via PM2 cluster mode, utilizing all available CPU cores
CMD ["pm2-runtime", "index.js", "-i", "max"]
