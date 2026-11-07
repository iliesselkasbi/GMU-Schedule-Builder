# Stage 1: Build the React + TypeScript + Vite application
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies first (leverages Docker layer caching)
COPY package*.json ./
RUN npm install

# Copy application source and compile the Vite production bundle
COPY . .
RUN npx vite build

# Stage 2: Serve static production assets using lightweight Nginx
FROM nginx:alpine

# Copy built Vite assets from builder stage to Nginx web root
COPY --from=builder /app/dist /usr/share/nginx/html

# Configure Nginx to support React Router (SPA routing for / and /admin)
RUN printf "server {\n    listen 80;\n    location / {\n        root /usr/share/nginx/html;\n        index index.html;\n        try_files \$uri \$uri/ /index.html;\n    }\n}\n" > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
