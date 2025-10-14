# Étape 1 : Build du site Astro
FROM node:18-alpine AS builder

WORKDIR /app

# Copier les fichiers de dépendances
COPY site/package*.json ./

# Installer les dépendances
RUN npm ci

# Copier le reste du code source
COPY site/ ./

# Build du site statique
RUN npm run build

# Étape 2 : Servir avec Nginx
FROM nginx:alpine

# Copier les fichiers buildés dans Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Copier la configuration Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
