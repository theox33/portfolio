# 📋 Résumé de la Configuration Docker

## ✅ Ce qui a été créé pour vous

### 📁 Fichiers de Configuration

| Fichier | Description | À modifier ? |
|---------|-------------|--------------|
| `Dockerfile` | Build multi-étapes (Node.js + Nginx) | ❌ Non |
| `docker-compose.yml` | Configuration production | ⚠️ Oui (port) |
| `docker-compose.dev.yml` | Configuration développement | ❌ Non |
| `nginx.conf` | Configuration du serveur web | ⚠️ Oui (si changement d'URL) |
| `.dockerignore` | Fichiers à exclure du build | ❌ Non |

### 🛠️ Scripts Utiles

| Script | Usage | Commande |
|--------|-------|----------|
| `deploy.sh` | Déploiement automatique | `./deploy.sh` |
| `backup.sh` | Créer un backup | `./backup.sh` |
| `check.sh` | Vérifier l'environnement | `./check.sh` |
| `Makefile` | Commandes simplifiées | `make help` |

### 📚 Documentation

| Fichier | Contenu |
|---------|---------|
| `README.md` | Documentation principale |
| `QUICKSTART.md` | Guide de démarrage rapide |
| `DEPLOY.md` | Guide détaillé de déploiement |
| `MIGRATION.md` | Guide de migration HTML → Astro |

---

## 🔄 Workflow Simplifié

### Pour Proxmox (Production)

```bash
# 1. Vérifier l'environnement
./check.sh

# 2. Déployer
./deploy.sh

# 3. C'est tout ! Le site est sur http://votre-ip:8080/portfolio/
```

---

## ⚙️ Configurations à Faire

### 1️⃣ Changer le port (OPTIONNEL)

**Si le port 8080 est déjà utilisé :**

Éditez `docker-compose.yml` :
```yaml
services:
  web:
    # ...
    ports:
      - "NOUVEAU_PORT:80"  # Ex: "3000:80"
```

### 2️⃣ Changer le domaine dans astro.config.mjs (OPTIONNEL)

Éditez `site/astro.config.mjs` :
```javascript
export default defineConfig({
  site: 'https://votre-domaine.com',  // Votre vrai domaine
  base: '/portfolio',
  // ...
});
```

### 3️⃣ Mettre à jour les infos de contact (IMPORTANT)

Éditez `site/src/content/profile.json` :
```json
{
  "name": "Théo AVRIL",
  "contact": {
    "email": "votre-vrai-email@example.com",  // ← Changez ici
    "github": "https://github.com/VotreUsername",
    "linkedin": "https://www.linkedin.com/in/votre-profil/"
  }
}
```

---

## 🚀 Commandes Principales

### Via Script (Recommandé)
```bash
./deploy.sh         # Déployer/Mettre à jour
./check.sh          # Vérifier l'environnement
./backup.sh         # Créer un backup
```

### Via Makefile (Alternative)
```bash
make help           # Voir toutes les commandes
make deploy         # Déployer
make logs           # Voir les logs
make down           # Arrêter
make restart        # Redémarrer
```

### Via Docker Compose Direct
```bash
# Utilisez "docker compose" (v2) ou "docker-compose" (v1)
docker compose build      # Builder
docker compose up -d      # Démarrer
docker compose down       # Arrêter
docker compose logs -f    # Logs
```

---

## 📦 Comparaison : Avant vs Maintenant

### ⏮️ Avant (HTML statique)
```bash
# Simple volume mount
docker run -v ./site:/usr/share/nginx/html nginx
```
- ✅ Simple
- ❌ Pas d'optimisations
- ❌ Pas d'animations modernes

### ▶️ Maintenant (Astro)
```bash
# Build multi-étapes
./deploy.sh
```
- ✅ UI moderne avec animations
- ✅ Performance optimisée
- ✅ Build automatique
- ⚠️ Nécessite un rebuild après modification

---

## 🎯 URLs du Site

| Environnement | URL | Commande |
|---------------|-----|----------|
| Production (Docker) | `http://localhost:8080/portfolio/` | `./deploy.sh` |
| Développement Local | `http://localhost:4321/` | `cd site && npm run dev` |
| Dev avec Docker | `http://localhost:4321/` | `make dev` |

---

## 🆘 Problèmes Courants & Solutions

### ❌ "Port already in use"
```bash
# Solution 1: Changer le port dans docker-compose.yml
ports:
  - "9000:80"

# Solution 2: Trouver et tuer le processus
sudo netstat -tulpn | grep 8080
sudo kill -9 PID
```

### ❌ "Build failed"
```bash
# Rebuild complet
docker compose down
docker compose build --no-cache
docker compose up -d
```

### ❌ "Site inaccessible"
```bash
# Vérifier les logs
docker compose logs

# Vérifier que le conteneur tourne
docker compose ps
```

---

## 📊 Taille de l'Image Docker

- **Image finale** : ~25 MB (Nginx Alpine)
- **Image de build** : ~200 MB (Node.js) - supprimée après build

Le Dockerfile utilise un **build multi-étapes** pour garder l'image finale légère.

---

## 🔐 Sécurité

Headers ajoutés dans `nginx.conf` :
- ✅ X-Frame-Options
- ✅ X-Content-Type-Options
- ✅ X-XSS-Protection
- ✅ Cache-Control pour assets

---

## 📝 Notes Importantes

1. **Après chaque modification du code**, vous devez :
   - Soit : `./deploy.sh` (production)
   - Soit : Hot-reload automatique si vous êtes en dev (`npm run dev`)

2. **Les fichiers buildés** sont dans `site/dist/` (généré automatiquement)

3. **Ne commitez pas** `node_modules/` ni `dist/` (déjà dans .gitignore)

4. **Backups** : Créés dans le dossier `backups/` (5 derniers conservés)

---

## ✅ Checklist de Déploiement

- [ ] Exécuter `./check.sh` pour vérifier l'environnement
- [ ] Modifier `site/src/content/profile.json` avec vos vraies infos
- [ ] (Optionnel) Changer le port dans `docker-compose.yml`
- [ ] (Optionnel) Changer le domaine dans `site/astro.config.mjs`
- [ ] Exécuter `./deploy.sh`
- [ ] Vérifier que le site est accessible
- [ ] Créer un backup avec `./backup.sh`

---

**🎉 Votre portfolio est prêt à être déployé !**

Pour démarrer : `./deploy.sh`
