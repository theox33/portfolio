# 📚 Index de la Documentation

Bienvenue ! Voici tous les fichiers de documentation disponibles pour votre portfolio.

## 🚀 Par où commencer ?

### Pour déployer rapidement (Proxmox/Production)
👉 **[QUICKSTART.md](QUICKSTART.md)** - Guide de démarrage en 30 secondes

### Pour comprendre la configuration complète
👉 **[SUMMARY.md](SUMMARY.md)** - Résumé de tous les fichiers et configurations

---

## 📖 Documentation Complète

### 🎯 Guides Essentiels

| Document | Description | Pour qui ? |
|----------|-------------|------------|
| **[README.md](README.md)** | Documentation principale | Tout le monde |
| **[QUICKSTART.md](QUICKSTART.md)** | Démarrage rapide (30 sec) | Débutants |
| **[SUMMARY.md](SUMMARY.md)** | Résumé de la config | Vue d'ensemble |

### 🐳 Docker & Déploiement

| Document | Description | Pour qui ? |
|----------|-------------|------------|
| **[DEPLOY.md](DEPLOY.md)** | Guide détaillé Docker | Production |
| **[MIGRATION.md](MIGRATION.md)** | Migration HTML → Astro | Ceux qui migrent |

### 💻 Code Source

| Document | Description | Pour qui ? |
|----------|-------------|------------|
| **[site/README.md](site/README.md)** | Doc technique du code Astro | Développeurs |

---

## 🛠️ Fichiers de Configuration

### Docker
- `Dockerfile` - Build multi-étapes
- `docker-compose.yml` - Config production
- `docker-compose.dev.yml` - Config développement
- `.dockerignore` - Exclusions Docker

### Serveur Web
- `nginx.conf` - Configuration Nginx

### Projet
- `.gitignore` - Exclusions Git
- `site/astro.config.mjs` - Config Astro
- `site/tailwind.config.cjs` - Config Tailwind

---

## 🔧 Scripts Disponibles

| Script | Description | Usage |
|--------|-------------|-------|
| `deploy.sh` | Déploiement automatique | `./deploy.sh` |
| `check.sh` | Vérification environnement | `./check.sh` |
| `backup.sh` | Créer un backup | `./backup.sh` |
| `Makefile` | Commandes simplifiées | `make help` |

---

## 📋 Workflows Recommandés

### 🎯 Première Installation
1. Lire → **[QUICKSTART.md](QUICKSTART.md)**
2. Exécuter → `./check.sh`
3. Exécuter → `./deploy.sh`
4. Visiter → `http://localhost:8080/portfolio/`

### 🔄 Mise à Jour du Code
1. Modifier les fichiers dans `site/src/`
2. Exécuter → `./deploy.sh`
3. Vérifier → `http://localhost:8080/portfolio/`

### 🐛 Débogage
1. Vérifier → `./check.sh`
2. Voir logs → `docker compose logs`
3. Consulter → **[DEPLOY.md](DEPLOY.md)** section Dépannage

### 💾 Backup Régulier
1. Exécuter → `./backup.sh`
2. Les backups sont dans `backups/`

---

## 🎯 Cas d'Usage

### "Je veux déployer rapidement"
→ **[QUICKSTART.md](QUICKSTART.md)** puis `./deploy.sh`

### "Je veux comprendre Docker"
→ **[DEPLOY.md](DEPLOY.md)**

### "Je viens de HTML/CSS basique"
→ **[MIGRATION.md](MIGRATION.md)**

### "Je veux modifier le code"
→ **[site/README.md](site/README.md)**

### "J'ai un problème"
→ **[DEPLOY.md](DEPLOY.md)** section 🆘 Dépannage

### "Je veux tout comprendre"
→ **[SUMMARY.md](SUMMARY.md)**

---

## 📂 Arborescence Complète

```
portfolio/
├── 📚 DOCUMENTATION
│   ├── README.md              # Doc principale
│   ├── INDEX.md              # Ce fichier
│   ├── QUICKSTART.md         # Démarrage rapide
│   ├── SUMMARY.md            # Résumé complet
│   ├── DEPLOY.md             # Guide Docker
│   └── MIGRATION.md          # Guide migration
│
├── 🐳 DOCKER
│   ├── Dockerfile
│   ├── docker-compose.yml
│   ├── docker-compose.dev.yml
│   ├── .dockerignore
│   └── nginx.conf
│
├── 🛠️ SCRIPTS
│   ├── deploy.sh             # Déploiement
│   ├── check.sh              # Vérification
│   ├── backup.sh             # Backup
│   └── Makefile              # Commandes
│
├── 💻 CODE SOURCE
│   └── site/
│       ├── README.md         # Doc technique
│       ├── src/              # Code Astro
│       ├── public/           # Assets
│       └── package.json
│
└── 📋 CONFIG
    ├── .gitignore
    └── site/
        ├── astro.config.mjs
        └── tailwind.config.cjs
```

---

## ⚡ Commandes Quick Reference

```bash
# Vérification
./check.sh

# Déploiement
./deploy.sh

# Backup
./backup.sh

# Aide Makefile
make help

# Logs
docker compose logs -f

# Arrêt
docker compose down

# Dev local
cd site && npm run dev
```

---

## 🔗 Liens Externes Utiles

- [Documentation Astro](https://docs.astro.build)
- [Documentation Tailwind CSS](https://tailwindcss.com/docs)
- [Documentation GSAP](https://greensock.com/docs/)
- [Documentation Docker](https://docs.docker.com/)
- [Documentation Nginx](https://nginx.org/en/docs/)

---

## 📞 Support

En cas de problème :

1. **Vérifier** → `./check.sh`
2. **Consulter** → [DEPLOY.md](DEPLOY.md) section Dépannage
3. **Logs** → `docker compose logs`
4. **Rebuild** → `make rebuild`

---

**🎉 Bonne navigation dans la documentation !**

*Conseil : Commencez par [QUICKSTART.md](QUICKSTART.md) si vous voulez déployer rapidement.*
