# 🔄 Guide de Migration : HTML/CSS → Astro + Docker

## 📊 Comparaison : Avant vs Maintenant

### ⏮️ AVANT (HTML/CSS statique)

**Structure :**
```
portfolio/
├── docker-compose.yml
├── nginx.conf
└── site/
    ├── index.html
    ├── style.css
    └── script.js
```

**docker-compose.yml :**
```yaml
services:
  web:
    image: nginx:alpine
    volumes:
      - ./site:/usr/share/nginx/html:ro  # Direct mount
```

**Workflow :**
1. Modifier `index.html` / `style.css`
2. Les changements sont immédiats (volume monté)
3. Rafraîchir le navigateur

---

### ▶️ MAINTENANT (Astro + Build)

**Structure :**
```
portfolio/
├── Dockerfile                    # ✨ Nouveau
├── docker-compose.yml           # Modifié
├── docker-compose.dev.yml       # ✨ Nouveau (dev)
├── nginx.conf                   # Amélioré
├── deploy.sh                    # ✨ Nouveau
├── backup.sh                    # ✨ Nouveau
├── Makefile                     # ✨ Nouveau
└── site/
    ├── src/                     # ✨ Code source
    ├── public/                  # ✨ Assets statiques
    ├── dist/                    # ✨ Généré par build
    └── package.json             # ✨ Dépendances
```

**Dockerfile (Build multi-étapes) :**
```dockerfile
# Étape 1: Build Astro
FROM node:18-alpine AS builder
WORKDIR /app
COPY site/ ./
RUN npm ci && npm run build

# Étape 2: Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```

**Workflow PRODUCTION :**
1. Modifier le code dans `site/src/`
2. Exécuter `./deploy.sh` ou `make deploy`
3. Docker rebuild et redéploie
4. Le site est mis à jour

**Workflow DÉVELOPPEMENT :**
1. Modifier le code dans `site/src/`
2. Le serveur Astro recharge automatiquement (hot-reload)
3. Voir les changements en temps réel

---

## 🚀 Migration Étape par Étape

### Étape 1 : Sauvegarde
```bash
# Sauvegarder l'ancienne version
./backup.sh
```

### Étape 2 : Arrêter l'ancien conteneur
```bash
docker-compose down
```

### Étape 3 : Déployer la nouvelle version
```bash
./deploy.sh
```

### Étape 4 : Vérifier
```bash
# Ouvrir dans le navigateur
http://localhost:8080/portfolio/
```

---

## 📝 Différences Clés

| Aspect | Avant (HTML) | Maintenant (Astro) |
|--------|--------------|-------------------|
| **Modification** | Éditer HTML direct | Éditer composants Astro |
| **Déploiement** | Immédiat (volume) | Rebuild Docker |
| **Performance** | Basique | Optimisé (minification, etc.) |
| **Animations** | CSS basique | GSAP + animations avancées |
| **Icônes** | Emojis / Images | astro-icon (optimisé) |
| **Hot Reload** | ❌ | ✅ (en dev) |
| **Build** | Aucun | `npm run build` |
| **Taille image** | ~23 MB | ~25 MB (optimisé) |

---

## 🛠️ Nouveaux Workflows

### Développement Local (Sans Docker)
```bash
cd site
npm install
npm run dev
# Ouvre http://localhost:4321
```

### Développement avec Docker + Hot Reload
```bash
make dev
# ou
docker-compose -f docker-compose.dev.yml up
```

### Production
```bash
make deploy
# ou
./deploy.sh
```

### Commandes Utiles
```bash
make help          # Voir toutes les commandes
make build         # Builder l'image
make up            # Démarrer
make down          # Arrêter
make logs          # Voir les logs
make restart       # Redémarrer
make clean         # Nettoyer
./backup.sh        # Créer un backup
```

---

## 🔧 Personnalisation

### Changer le port (8080 → autre)

**docker-compose.yml :**
```yaml
ports:
  - "3000:80"  # Port 3000 au lieu de 8080
```

### Servir à la racine (/) au lieu de (/portfolio/)

**1. astro.config.mjs :**
```javascript
export default defineConfig({
  base: '/',  // Au lieu de '/portfolio'
  // ...
});
```

**2. nginx.conf :**
```nginx
location / {
    try_files $uri $uri/ /index.html;
}
```

### Ajouter HTTPS

**nginx.conf :**
```nginx
server {
    listen 443 ssl;
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    # ...
}
```

**docker-compose.yml :**
```yaml
volumes:
  - ./ssl:/etc/nginx/ssl:ro
ports:
  - "443:443"
```

---

## ❓ FAQ

### Q: Pourquoi un Dockerfile au lieu de volumes ?
**R:** Astro nécessite un build (`npm run build`) pour générer les fichiers statiques. Le Dockerfile automatise ce processus.

### Q: C'est plus complexe, non ?
**R:** Plus de fichiers, mais :
- Scripts automatisés (`deploy.sh`, `Makefile`)
- Meilleure performance
- Animations et UI modernes
- Hot-reload en dev

### Q: Puis-je revenir à l'ancien système ?
**R:** Oui ! Vos backups sont dans `backups/`. Restaurez avec :
```bash
tar -xzf backups/portfolio_backup_XXXXX.tar.gz
```

### Q: Comment déboguer ?
```bash
# Voir les logs
docker-compose logs -f

# Accéder au conteneur
docker-compose exec web sh

# Vérifier le build
cd site && npm run build
```

---

## 🎯 Avantages de la Nouvelle Config

✅ **UI Moderne** : Animations GSAP, gradients, effets 3D
✅ **Performance** : Build optimisé, minification auto
✅ **SEO** : Sitemap automatique
✅ **Dev Experience** : Hot-reload, composants réutilisables
✅ **Maintenabilité** : Code organisé en composants
✅ **Sécurité** : Headers de sécurité dans Nginx
✅ **Backup** : Script automatique
✅ **Simplicité** : Makefile et scripts de déploiement

---

## 🚨 Points d'Attention

⚠️ **Build Time** : Le premier build peut prendre 30-60s (installation des dépendances)
⚠️ **Cache Docker** : Utilisez `--no-cache` si les dépendances ne s'installent pas
⚠️ **Base Path** : Vérifiez que `base: '/portfolio'` correspond à votre config Nginx

---

## 📞 Support

En cas de problème :

1. **Vérifier les logs** : `make logs`
2. **Rebuild propre** : `make rebuild`
3. **Vérifier la config** : Lire `DEPLOY.md`
4. **Restaurer backup** : `tar -xzf backups/portfolio_backup_*.tar.gz`

---

🎉 **Félicitations !** Votre portfolio est maintenant moderne et performant !
