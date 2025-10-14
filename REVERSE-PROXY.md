# Configuration Reverse Proxy pour theo-avril.fr

## 🔍 Diagnostic

Votre conteneur Docker tourne sur :
- **Port** : 8080
- **Container** : portfolio
- **Service interne** : port 80

## ✅ Configuration Nginx Reverse Proxy

Si vous utilisez Nginx comme reverse proxy devant votre conteneur, voici la config :

```nginx
server {
    listen 80;
    server_name theo-avril.fr www.theo-avril.fr;

    # Redirection HTTP vers HTTPS (si SSL)
    # return 301 https://$server_name$request_uri;

    # OU si pas de SSL, proxy direct :
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# Si vous avez SSL/HTTPS
server {
    listen 443 ssl http2;
    server_name theo-avril.fr www.theo-avril.fr;

    # Certificats SSL
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 🔧 Commandes de diagnostic

### 1. Vérifier que le conteneur est accessible localement
```bash
curl http://localhost:8080/
```

### 2. Tester depuis l'extérieur du serveur
```bash
curl http://theo-avril.fr/
```

### 3. Vérifier les logs du reverse proxy
```bash
# Si c'est Nginx système
sudo tail -f /var/log/nginx/error.log

# Si c'est Apache
sudo tail -f /var/log/apache2/error.log
```

### 4. Vérifier la config Nginx
```bash
# Tester la config
sudo nginx -t

# Recharger Nginx
sudo systemctl reload nginx
```

## 🐛 Problèmes courants

### Erreur 502 Bad Gateway
**Cause** : Le reverse proxy ne peut pas joindre le backend
**Solution** :
- Vérifier que le conteneur tourne : `docker ps`
- Vérifier que le port 8080 est ouvert : `curl http://localhost:8080/`
- Vérifier la config du reverse proxy (voir ci-dessus)

### Erreur MIME type
**Cause** : Le reverse proxy sert une page d'erreur HTML au lieu du fichier JS
**Solution** :
- Corriger le reverse proxy pour qu'il proxy correctement
- S'assurer que tous les assets passent par le proxy

## 📁 Où trouver votre config de reverse proxy ?

Sur Proxmox/Debian/Ubuntu, selon votre setup :

```bash
# Nginx
/etc/nginx/sites-available/theo-avril.fr
/etc/nginx/sites-enabled/theo-avril.fr
/etc/nginx/conf.d/theo-avril.fr.conf

# Apache
/etc/apache2/sites-available/theo-avril.fr.conf
/etc/apache2/sites-enabled/theo-avril.fr.conf
```

## ✅ Config Minimale Fonctionnelle (Nginx)

Créez `/etc/nginx/sites-available/theo-avril.fr` :

```nginx
server {
    listen 80;
    server_name theo-avril.fr www.theo-avril.fr;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Activez-la :
```bash
sudo ln -s /etc/nginx/sites-available/theo-avril.fr /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## 🚀 Déploiement après correction

1. Sur votre serveur, redéployez le portfolio :
```bash
cd ~/portfolio
./deploy.sh
```

2. Configurez/corrigez votre reverse proxy (voir config ci-dessus)

3. Rechargez le reverse proxy :
```bash
sudo systemctl reload nginx  # ou apache2
```

4. Testez :
```bash
curl http://theo-avril.fr/
```
