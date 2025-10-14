# 🎨 Portfolio - Théo AVRIL

Portfolio personnel moderne avec Astro, Tailwind CSS, GSAP et Docker.

> 👨‍💻 **Théo AVRIL** - Étudiant ingénieur généraliste à l'ESEO, spécialisé en systèmes embarqués

## 🚀 Démarrage Rapide

### Option 1 : Déploiement Production (Docker)
```bash
./deploy.sh
```
Accès : http://localhost:8080/portfolio/

### Option 2 : Développement Local
```bash
cd site
npm install
npm run dev
```
Accès : http://localhost:4321/

### Option 3 : Makefile (Simple)
```bash
make help     # Voir toutes les commandes
make deploy   # Déployer
make dev      # Dev avec Docker
```

## 📚 Documentation

- 📖 [Guide de Déploiement](DEPLOY.md) - Instructions Docker détaillées
- 🔄 [Guide de Migration](MIGRATION.md) - Migration HTML → Astro
- 💻 [README du Site](site/README.md) - Documentation technique du code

## 🛠️ Technologies

- **[Astro](https://astro.build)** - Framework web moderne
- **[Tailwind CSS](https://tailwindcss.com)** - Framework CSS
- **[GSAP](https://greensock.com/gsap/)** - Animations avancées
- **[Docker](https://www.docker.com/)** - Conteneurisation
- **[Nginx](https://nginx.org/)** - Serveur web

## 📁 Structure

```
portfolio/
├── Dockerfile                # Build multi-étapes
├── docker-compose.yml        # Config production
├── docker-compose.dev.yml    # Config développement
├── nginx.conf               # Configuration Nginx
├── deploy.sh                # Script de déploiement
├── backup.sh                # Script de backup
├── Makefile                 # Commandes simplifiées
├── DEPLOY.md               # Guide déploiement
├── MIGRATION.md            # Guide migration
└── site/                   # Code source Astro
    ├── src/
    │   ├── components/     # Composants Astro
    │   ├── layouts/        # Layouts
    │   ├── pages/          # Pages
    │   ├── scripts/        # JavaScript
    │   └── styles/         # CSS
    ├── public/             # Assets statiques
    └── package.json
```

## 🎯 Commandes Principales

### Production
```bash
./deploy.sh              # Déployer
make deploy              # Déployer (via Makefile)
docker-compose up -d     # Démarrer
docker-compose down      # Arrêter
docker-compose logs -f   # Logs
```

### Développement
```bash
cd site && npm run dev         # Dev local
make dev                       # Dev avec Docker
make dev-local                 # Dev local (via Makefile)
```

### Maintenance
```bash
./backup.sh                    # Créer un backup
make clean                     # Nettoyer Docker
make rebuild                   # Rebuild complet
```

## 🔧 Configuration

### Changer le port
Éditez `docker-compose.yml` :
```yaml
ports:
  - "VOTRE_PORT:80"
```

### Changer l'URL de base
Éditez `site/astro.config.mjs` :
```javascript
base: '/votre-chemin'
```

## 📊 Caractéristiques

✨ **Design Moderne**
- Hero section avec gradients animés
- Glass morphism
- Effets 3D et parallax
- Curseur personnalisé

🎭 **Animations**
- GSAP pour animations fluides
- Scroll-driven animations
- Effets magnétiques
- Hover effects avancés

⚡ **Performance**
- Build optimisé
- Image Docker légère (~25 MB)
- Cache Nginx
- View Transitions

🔒 **Sécurité**
- Headers de sécurité
- Configuration Nginx sécurisée

## 🐳 Docker

L'image utilise un **build multi-étapes** :
1. **Builder** (Node.js) : Build du site Astro
2. **Runtime** (Nginx) : Sert les fichiers statiques

Résultat : Image finale très légère.

## 🆘 Dépannage

### Le site ne démarre pas
```bash
# Voir les logs
docker-compose logs

# Rebuild propre
make rebuild
```

### Erreur de build
```bash
# Nettoyer et rebuilder
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Port déjà utilisé
```bash
# Trouver le processus
sudo netstat -tulpn | grep 8080

# Tuer le processus ou changer le port
```

---

## 👨‍� À propos de moi

- 🎓 Ingénieur généraliste en dernière année, spécialité **Systèmes Embarqués**  
- 💡 Intérêt pour l'**architecture systèmes**, la **sécurité logicielle**, et la **communication multi-plateformes**  
- 🌍 Expérience en projets collaboratifs (**Thales, PFE, projets personnels**)

## 🛠️ Compétences principales

![C](https://img.shields.io/badge/C-00599C?style=flat&logo=c&logoColor=white)
![Java](https://img.shields.io/badge/Java-ED8B00?style=flat&logo=openjdk&logoColor=white)
![Kotlin](https://img.shields.io/badge/Kotlin-7F52FF?style=flat&logo=kotlin&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat&logo=typescript&logoColor=white)

- **Systèmes embarqués** : C, RTOS, STM32, Linux embarqué
- **Communication & Sécurité** : TLS/SSL, Protobuf
- **Développement Android** : Java/Kotlin
- **Développement Web** : React, NestJS, Supabase

## 📜 Certifications

- 📄 TOEIC : **955/990** [🔗 certificat](https://www.etsglobal.org/fr/en/digital-score-report/253E130E0E72F6D0CE5A84223FDFFCE120624922FC0DB50F512AC1F346E3D85BeUFBelg4UVV5KzJxN0tCSzhaUnY4UHdDREFpNWdKMkxwbjZGdkl5R0lEWHBFMkd6)  
- ✍️ Voltaire : **718 (Orthographe Affaires)** [🔗 certificat](https://mon.certificat-voltaire.fr/verification-certificat?code=TL4KTPW)  

## 📊 Statistiques GitHub

<p align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=theox33&show_icons=true&theme=tokyonight" alt="GitHub stats" height="160"/>
  <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=theox33&layout=compact&theme=tokyonight" alt="Langages les plus utilisés" height="160"/>
</p>

## 📫 Contact

- 💼 [LinkedIn](https://www.linkedin.com/in/théo-avril-a52626237)  
- 📧 theo.avril@reseau.eseo.fr  
- 🌐 [Portfolio Web](http://theo-avril.synology.me)  

---

## 📝 Licence

MIT © 2025 Théo AVRIL

---

**Pour commencer :** `./deploy.sh` 🚀
