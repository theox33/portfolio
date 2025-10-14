# 🐳 Déploiement Docker du Portfolio

Ce guide explique comment déployer votre portfolio Astro avec Docker et Nginx, similaire à votre ancienne configuration.

## 📋 Prérequis

- Docker installé
- Docker Compose installé

## 🚀 Déploiement Rapide

### Méthode 1 : Script automatique (Recommandé)

```bash
./deploy.sh
```

### Méthode 2 : Commandes manuelles

```bash
# 1. Builder l'image Docker
docker-compose build

# 2. Démarrer le conteneur
docker-compose up -d

# 3. Voir les logs
docker-compose logs -f
```

## 🔄 Mise à jour du site

Après avoir modifié le code :

```bash
# Rebuilder et redéployer
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

Ou simplement :
```bash
./deploy.sh
```

## 🌐 Accès au site

Le site sera accessible sur :
- **Local** : http://localhost:8080/portfolio/
- **Serveur** : http://votre-ip:8080/portfolio/

## 📁 Structure des fichiers Docker

```
portfolio/
├── Dockerfile              # Build multi-étapes (Node.js + Nginx)
├── docker-compose.yml      # Configuration Docker Compose
├── nginx.conf             # Configuration Nginx
├── deploy.sh              # Script de déploiement automatique
└── site/                  # Code source Astro
    ├── src/
    ├── public/
    └── package.json
```

## 🔧 Configuration

### Changer le port

Éditez `docker-compose.yml` :
```yaml
ports:
  - "VOTRE_PORT:80"  # Ex: "3000:80"
```

### Changer le chemin d'accès

Éditez `site/astro.config.mjs` :
```javascript
export default defineConfig({
  base: '/votre-chemin',  // Ex: '/portfolio' ou '/'
  // ...
});
```

Puis éditez `nginx.conf` pour adapter la location.

### Servir à la racine (/)

1. Dans `astro.config.mjs`, changez `base: '/'`
2. Dans `nginx.conf`, remplacez :
```nginx
location / {
    try_files $uri $uri/ /index.html;
}
```

## 🛠️ Commandes utiles

```bash
# Voir les conteneurs en cours
docker-compose ps

# Arrêter le conteneur
docker-compose stop

# Supprimer le conteneur
docker-compose down

# Voir les logs en temps réel
docker-compose logs -f

# Accéder au shell du conteneur
docker-compose exec web sh

# Rebuild forcé
docker-compose build --no-cache
```

## 🔍 Dépannage

### Le site ne s'affiche pas
1. Vérifiez que le conteneur tourne : `docker-compose ps`
2. Vérifiez les logs : `docker-compose logs`
3. Vérifiez que le port 8080 est libre : `netstat -tulpn | grep 8080`

### Erreur de build
1. Vérifiez que Node.js 18+ est dans le Dockerfile
2. Vérifiez que toutes les dépendances sont dans `package.json`
3. Essayez un rebuild : `docker-compose build --no-cache`

### Les assets ne se chargent pas
1. Vérifiez que `base: '/portfolio'` est bien dans `astro.config.mjs`
2. Vérifiez que les chemins dans `nginx.conf` correspondent

## 🆚 Différences avec l'ancienne configuration

### Avant (HTML/CSS statique)
```yaml
volumes:
  - ./site:/usr/share/nginx/html:ro
```

### Maintenant (Astro)
```dockerfile
# Build dans Docker
COPY --from=builder /app/dist /usr/share/nginx/html
```

**Pourquoi ?** Astro doit être "buildé" (comme `npm run build`) pour générer les fichiers HTML/CSS/JS statiques dans le dossier `dist/`.

## 📊 Performance

Le Dockerfile utilise un **build multi-étapes** :
1. **Étape 1** : Build avec Node.js (génère `dist/`)
2. **Étape 2** : Copie uniquement `dist/` dans Nginx (image légère)

Résultat : Image Docker finale très légère (~25 MB) au lieu de ~200 MB avec Node.js.

## 🔐 Sécurité

Headers de sécurité ajoutés dans `nginx.conf` :
- X-Frame-Options
- X-Content-Type-Options
- X-XSS-Protection

## 📝 Notes

- Le site est buildé à chaque `docker-compose build`
- Pour du développement, utilisez `npm run dev` en local
- Pour la production, utilisez Docker

---

✅ **C'est prêt !** Exécutez `./deploy.sh` pour déployer votre portfolio.
