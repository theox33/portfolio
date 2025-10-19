# ⚡ Configuration rapide Nginx Proxy Manager

## 🎯 Objectif
Servir `robots.txt` à `https://theo-avril.fr/robots.txt` (racine du domaine)

---

## 📝 Configuration dans NPM (Interface Web)

### 1. Ouvrez Nginx Proxy Manager
URL : `http://votre-ip:81` (par défaut)

### 2. Éditez le Proxy Host pour `theo-avril.fr`
Cliquez sur les **3 points** → **Edit**

### 3. Onglet "Advanced"
Collez cette configuration dans le champ "Custom Nginx Configuration" :

```nginx
# Servir robots.txt à la racine du domaine
location = /robots.txt {
    proxy_pass http://portfolio:80/robots.txt;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    add_header Content-Type text/plain;
}
```

**Notes :**
- Remplacez `portfolio:80` par `localhost:8080` si le container est sur la même machine avec le port 8080
- Ou utilisez l'IP du container si besoin

### 4. Sauvegardez
Cliquez sur **Save** → NPM recharge automatiquement

---

## ✅ Vérification

Depuis votre serveur, testez :

```bash
# Test 1 : robots.txt à la racine
curl -sL https://theo-avril.fr/robots.txt

# Attendu :
# User-agent: *
# Allow: /
# Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml

# Test 2 : Portfolio toujours accessible
curl -I https://theo-avril.fr/portfolio/

# Attendu : HTTP/2 200
```

---

## 🐛 Si ça ne marche pas

### Option A : Vérifier le nom du container

```bash
# Lister les containers
docker ps

# Si le nom n'est pas "portfolio", utilisez le bon nom dans NPM
# Exemple : si le nom est "my-portfolio", utilisez :
# proxy_pass http://my-portfolio:80/robots.txt;
```

### Option B : Utiliser l'IP du container

```bash
# Trouver l'IP du container
docker inspect portfolio | grep IPAddress

# Exemple de résultat : "IPAddress": "172.18.0.3"
# Utilisez cette IP dans NPM :
# proxy_pass http://172.18.0.3:80/robots.txt;
```

### Option C : Utiliser localhost (si port exposé)

Si votre container expose le port 8080 sur l'hôte :
```nginx
proxy_pass http://localhost:8080/robots.txt;
```

---

## 📋 Résumé

1. ✅ Code mis à jour (robots.txt, Dockerfile, nginx.conf)
2. ✅ Configuration NPM ajoutée (onglet Advanced)
3. ✅ Tests de vérification à faire

**Après ces étapes, `https://theo-avril.fr/robots.txt` sera accessible !** 🎉
