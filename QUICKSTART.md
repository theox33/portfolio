# ⚡ Quick Start Guide

## 🎯 Pour Proxmox / Production

### 1️⃣ Cloner le repo sur votre CT Proxmox
```bash
git clone https://github.com/theox33/portfolio.git
cd portfolio
```

### 2️⃣ Déployer immédiatement
```bash
./deploy.sh
```

### 3️⃣ Accéder au site
```
http://votre-ip:8080/portfolio/
```

C'est tout ! 🎉

---

## 🔄 Pour mettre à jour après modifications

### Si vous modifiez le code :
```bash
# Méthode 1 : Script automatique
./deploy.sh

# Méthode 2 : Commandes manuelles
docker-compose down
docker-compose build
docker-compose up -d
```

---

## 🛠️ Commandes Utiles

```bash
# Voir si ça tourne
docker-compose ps

# Voir les logs
docker-compose logs -f

# Arrêter
docker-compose down

# Redémarrer
docker-compose restart

# Backup
./backup.sh
```

---

## ⚙️ Configuration Rapide

### Changer le port (8080 → autre)
Éditez `docker-compose.yml` ligne 10 :
```yaml
ports:
  - "3000:80"  # Nouveau port
```

### Changer l'URL (/portfolio/ → autre)
1. Éditez `site/astro.config.mjs` ligne 11 :
```javascript
base: '/mon-site',
```

2. Éditez `nginx.conf` ligne 13 :
```nginx
location /mon-site/ {
```

---

## 📝 Fichiers Importants

| Fichier | Description |
|---------|-------------|
| `deploy.sh` | Script de déploiement automatique |
| `docker-compose.yml` | Config Docker production |
| `nginx.conf` | Config du serveur web |
| `Dockerfile` | Instructions de build |
| `site/` | Code source du site |

---

## 🆘 Problèmes Courants

### ❌ Port déjà utilisé
```bash
# Changer le port dans docker-compose.yml
ports:
  - "9000:80"  # Autre port
```

### ❌ Erreur de build
```bash
docker-compose build --no-cache
docker-compose up -d
```

### ❌ Site inaccessible
```bash
# Vérifier les logs
docker-compose logs

# Vérifier que ça tourne
docker-compose ps
```

---

## 📚 Plus d'infos

- [Guide complet de déploiement](DEPLOY.md)
- [Guide de migration](MIGRATION.md)
- [Documentation du code](site/README.md)

---

**Démarrage en 30 secondes :** `./deploy.sh` ⚡
