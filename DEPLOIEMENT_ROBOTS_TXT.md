# 🚀 Guide de déploiement : Correction robots.txt

## ✅ Corrections effectuées

### 1. **robots.txt corrigé** (`site/public/robots.txt`)
- ✅ URLs mises à jour pour pointer vers la bonne structure
- ✅ Sitemap correctement référencé

### 2. **Nginx configuré** (`nginx.conf`)
- ✅ Route explicite pour `/robots.txt`
- ✅ Route explicite pour les sitemaps XML
- ✅ Headers Content-Type corrects

### 3. **Dockerfile optimisé** (`Dockerfile`)
- ✅ Copie automatique de `robots.txt` à la racine de Nginx
- ✅ Garantit que le fichier sera accessible à `/robots.txt`

### 4. **Script de build** (`build.sh`)
- ✅ Script pour builder localement et vérifier

---

## 📋 Étapes de déploiement

### Option 1 : Déploiement Docker (RECOMMANDÉ)

```bash
# 1. Se placer à la racine du projet
cd /home/theo/portfolio

# 2. Rebuild l'image Docker (inclut les corrections)
docker-compose build

# 3. Redémarrer le container
docker-compose down
docker-compose up -d

# 4. Vérifier que le container tourne
docker-compose ps

# 5. Tester l'accès au robots.txt
curl http://localhost:8080/robots.txt

# 6. Tester l'accès au sitemap
curl http://localhost:8080/portfolio/sitemap-index.xml
```

### Option 2 : Build local (pour tester avant Docker)

```bash
# Utiliser le script de build
cd /home/theo/portfolio
./build.sh

# Vérifier que robots.txt est bien dans dist/
ls -la site/dist/robots.txt
cat site/dist/robots.txt
```

---

## 🧪 Tests de validation

### Test 1 : Accès local (après docker-compose up)
```bash
# Test robots.txt
curl http://localhost:8080/robots.txt

# Attendu :
# User-agent: *
# Allow: /
# Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
```

### Test 2 : Accès production
```bash
# Test robots.txt en production
curl https://theo-avril.fr/robots.txt

# Test sitemap
curl https://theo-avril.fr/portfolio/sitemap-index.xml
```

### Test 3 : Vérifier dans le navigateur
Ouvrez directement :
- `https://theo-avril.fr/robots.txt` → doit afficher le contenu
- `https://theo-avril.fr/portfolio/` → votre site
- `https://theo-avril.fr/portfolio/sitemap-index.xml` → le sitemap

### Test 4 : Google Search Console
1. Allez dans Google Search Console
2. Menu : "Paramètres" → "Exploration" → "robots.txt"
3. Vérifiez que Google peut lire le fichier

---

## 🔍 Débogage

### Problème : 404 sur robots.txt

**Vérifications :**

1. **Le fichier existe-t-il dans le container ?**
   ```bash
   docker exec -it portfolio ls -la /usr/share/nginx/html/robots.txt
   ```

2. **Nginx est-il bien configuré ?**
   ```bash
   docker exec -it portfolio cat /etc/nginx/conf.d/default.conf | grep robots
   ```

3. **Les logs Nginx montrent-ils des erreurs ?**
   ```bash
   docker logs portfolio
   ```

### Problème : Mauvais contenu dans robots.txt

**Solution :**
```bash
# 1. Vérifier le fichier source
cat /home/theo/portfolio/site/public/robots.txt

# 2. Rebuild l'image
docker-compose build --no-cache

# 3. Redémarrer
docker-compose up -d
```

---

## 📁 Structure des fichiers après build

```
/usr/share/nginx/html/       (dans le container)
├── robots.txt               ← À la racine (✅ accessible à /robots.txt)
├── portfolio/
│   ├── index.html
│   ├── sitemap-index.xml
│   ├── sitemap-0.xml
│   ├── images/
│   └── ...
```

---

## 🎯 Checklist finale

- [ ] Fichiers modifiés :
  - [x] `site/public/robots.txt` → URLs corrigées
  - [x] `nginx.conf` → Routes ajoutées
  - [x] `Dockerfile` → Copie de robots.txt
  - [x] `build.sh` → Script de build créé

- [ ] Build et test local :
  - [ ] `./build.sh` exécuté avec succès
  - [ ] `site/dist/robots.txt` existe

- [ ] Déploiement Docker :
  - [ ] `docker-compose build` réussi
  - [ ] `docker-compose up -d` réussi
  - [ ] Container "portfolio" en cours d'exécution

- [ ] Tests d'accès :
  - [ ] `curl http://localhost:8080/robots.txt` → OK
  - [ ] `curl http://localhost:8080/portfolio/` → OK
  - [ ] `curl https://theo-avril.fr/robots.txt` → OK (en prod)

- [ ] Google Search Console :
  - [ ] robots.txt visible dans l'outil
  - [ ] Sitemap soumis et validé

---

## 🚀 Commandes rapides

```bash
# Tout-en-un : rebuild et redémarrer
cd /home/theo/portfolio && \
docker-compose build && \
docker-compose down && \
docker-compose up -d && \
sleep 2 && \
echo "🧪 Test robots.txt:" && \
curl http://localhost:8080/robots.txt

# Logs en temps réel
docker logs -f portfolio

# Arrêter
docker-compose down
```

---

## 📞 Besoin d'aide ?

Si vous rencontrez toujours des problèmes après ces étapes, vérifiez :
1. Les logs Docker : `docker logs portfolio`
2. Les permissions du fichier : `ls -la site/public/robots.txt`
3. La configuration de votre reverse proxy (si vous en utilisez un)

---

## ✅ Résultat attendu

Après ces modifications et le redéploiement :

1. ✅ `https://theo-avril.fr/robots.txt` → accessible (code 200)
2. ✅ Contenu correct avec sitemap référencé
3. ✅ Google peut crawler votre site
4. ✅ Sitemap visible dans Google Search Console

🎉 **Votre site est maintenant parfaitement configuré pour le SEO !**
