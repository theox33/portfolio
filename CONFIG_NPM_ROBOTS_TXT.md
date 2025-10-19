# 🎯 Configuration Nginx Proxy Manager pour robots.txt à la racine

## Objectif

Servir `robots.txt` à la racine du domaine :
```
✅ https://theo-avril.fr/robots.txt
✅ https://theo-avril.fr/portfolio/
```

---

## 📋 Étape 1 : Remettre robots.txt à la racine (code)

D'abord, annulons les modifications précédentes pour revenir à un robots.txt "universel" :

### Modifier `site/public/robots.txt` :

```txt
# robots.txt pour https://theo-avril.fr/

User-agent: *
Allow: /

# Sitemap
Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
```

---

## 🔧 Étape 2 : Configurer Nginx Proxy Manager

### Option A : Via l'interface Web (RECOMMANDÉ)

1. **Ouvrez Nginx Proxy Manager** (généralement `http://votre-ip:81`)

2. **Modifiez votre Proxy Host** pour `theo-avril.fr` :
   - Cliquez sur les 3 points → "Edit"

3. **Onglet "Custom Locations"** :
   
   Ajoutez **2 locations** :

   **Location 1 : robots.txt**
   - Define Location : `/robots.txt`
   - Scheme : `http://`
   - Forward Hostname / IP : `portfolio` (ou `localhost` si sur la même machine)
   - Forward Port : `80` (ou le port du container, ex: `8080`)
   - ✅ Cochez "Websockets Support" (optionnel mais recommandé)
   - ✅ Cochez "Block Common Exploits"

   **Location 2 : Portfolio (si pas déjà configuré)**
   - Define Location : `/portfolio`
   - Scheme : `http://`
   - Forward Hostname / IP : `portfolio`
   - Forward Port : `80`
   - ✅ Cochez "Websockets Support"
   - ✅ Cochez "Block Common Exploits"

4. **Onglet "Advanced"** (optionnel mais recommandé) :

   Ajoutez cette configuration pour gérer correctement les headers :

   ```nginx
   # Servir robots.txt à la racine
   location = /robots.txt {
       proxy_pass http://portfolio:80/robots.txt;
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;
       add_header Content-Type text/plain;
   }

   # Servir sitemap à la racine du portfolio
   location ~ ^/portfolio/(sitemap.*\.xml)$ {
       proxy_pass http://portfolio:80/$1;
       proxy_set_header Host $host;
       add_header Content-Type application/xml;
   }
   ```

5. **Sauvegardez** et attendez quelques secondes que NPM recharge la config.

---

### Option B : Via fichier de configuration (si accès SSH au serveur NPM)

Si vous avez accès aux fichiers de config de NPM (généralement dans `/data/nginx/proxy_host/`) :

**Fichier : `/data/nginx/proxy_host/X.conf`** (X = ID de votre proxy host)

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name theo-avril.fr;

    # Redirection HTTP → HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name theo-avril.fr;

    # Certificats SSL (gérés par NPM)
    ssl_certificate /etc/letsencrypt/live/npm-X/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/npm-X/privkey.pem;

    # robots.txt à la racine
    location = /robots.txt {
        proxy_pass http://portfolio:80/robots.txt;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        add_header Content-Type text/plain;
    }

    # Sitemap
    location ~ ^/portfolio/(sitemap.*\.xml)$ {
        proxy_pass http://portfolio:80/$1;
        proxy_set_header Host $host;
        add_header Content-Type application/xml;
    }

    # Portfolio principal
    location /portfolio/ {
        proxy_pass http://portfolio:80/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Page d'accueil (optionnel - redirige vers /portfolio/)
    location = / {
        return 301 /portfolio/;
    }
}
```

Puis redémarrez Nginx Proxy Manager :
```bash
docker restart nginx-proxy-manager
```

---

## 📝 Étape 3 : Mettre à jour le code source

### Modifier `site/public/robots.txt` :

```txt
# robots.txt pour https://theo-avril.fr/

User-agent: *
Allow: /

# Sitemap
Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
```

### Remettre la copie dans le Dockerfile :

```dockerfile
# Production stage with Nginx
FROM nginx:alpine

# Copy built files from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy robots.txt to root (important for SEO - must be at domain root)
COPY --from=builder /app/public/robots.txt /usr/share/nginx/html/robots.txt

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### Remettre les routes dans `nginx.conf` :

```nginx
server {
    listen 80 default_server;
    server_name _;
    
    root /usr/share/nginx/html;
    index index.html;

    # Gestion des erreurs 404 pour Astro
    error_page 404 /404.html;

    # Servir robots.txt explicitement (important pour SEO)
    location = /robots.txt {
        try_files /robots.txt =404;
        add_header Content-Type text/plain;
    }

    # Servir sitemap.xml explicitement
    location ~* ^/(sitemap.*\.xml)$ {
        try_files /$1 =404;
        add_header Content-Type application/xml;
    }

    # Servir le site depuis la racine
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Headers de sécurité
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Cache pour les assets statiques
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Désactiver le cache pour le HTML
    location ~* \.html$ {
        expires -1;
        add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0";
    }
}
```

---

## 🚀 Étape 4 : Rebuild et tester

```bash
cd /home/theo/portfolio

# 1. Rebuild Docker
docker compose build

# 2. Redémarrer
docker compose down
docker compose up -d

# 3. Tester en local (depuis le container)
docker exec portfolio cat /usr/share/nginx/html/robots.txt

# 4. Tester via le proxy (depuis le serveur)
curl -sL http://localhost:8080/robots.txt

# 5. Tester en production (HTTPS)
curl -sL https://theo-avril.fr/robots.txt
```

---

## ✅ Vérifications finales

### Test 1 : robots.txt accessible à la racine
```bash
curl -I https://theo-avril.fr/robots.txt
```

**Attendu :**
```
HTTP/2 200
content-type: text/plain
```

### Test 2 : Contenu correct
```bash
curl -sL https://theo-avril.fr/robots.txt
```

**Attendu :**
```txt
User-agent: *
Allow: /

Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
```

### Test 3 : Portfolio toujours accessible
```bash
curl -I https://theo-avril.fr/portfolio/
```

**Attendu :**
```
HTTP/2 200
content-type: text/html
```

### Test 4 : Sitemap accessible
```bash
curl -I https://theo-avril.fr/portfolio/sitemap-index.xml
```

**Attendu :**
```
HTTP/2 200
content-type: application/xml
```

---

## 🎯 Schéma de l'architecture finale

```
Internet
    ↓
[Nginx Proxy Manager]
    ↓
    ├── /robots.txt          → [Container portfolio:80] /robots.txt
    ├── /portfolio/          → [Container portfolio:80] /
    └── /portfolio/sitemap-* → [Container portfolio:80] /sitemap-*
```

---

## 🐛 Débogage

### Problème : 404 sur /robots.txt après config NPM

**Vérifications :**

1. **Le container portfolio sert bien robots.txt ?**
   ```bash
   curl http://localhost:8080/robots.txt
   ```

2. **NPM a bien rechargé la config ?**
   ```bash
   docker logs nginx-proxy-manager | tail -20
   ```

3. **Le fichier existe dans le container ?**
   ```bash
   docker exec portfolio ls -la /usr/share/nginx/html/robots.txt
   ```

### Problème : 502 Bad Gateway

**Cause :** NPM ne peut pas joindre le container `portfolio`

**Solution :**
- Vérifiez que le nom `portfolio` est correct dans NPM
- OU utilisez `localhost` si sur la même machine
- OU utilisez l'IP du container : `docker inspect portfolio | grep IPAddress`

---

## 📞 Besoin d'aide ?

Si vous avez des questions ou des erreurs, fournissez-moi :
1. Les logs NPM : `docker logs nginx-proxy-manager`
2. Le résultat de : `curl -I https://theo-avril.fr/robots.txt`
3. Le résultat de : `docker exec portfolio ls -la /usr/share/nginx/html/`

🚀 **Bonne configuration !**
