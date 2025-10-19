# Multi-stage build for Astro portfolio
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY site/package*.json ./

# Install dependencies
RUN npm install

# Copy source files
COPY site/ ./

# Build the project
RUN npm run build

# Production stage with Nginx
FROM nginx:alpine

# Copy built files from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
