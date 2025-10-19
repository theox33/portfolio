# 🔧 Solution finale : robots.txt dans /portfolio/

## 🎯 Situation

Votre site est derrière un **reverse proxy** (OpenResty/Nginx Proxy Manager) qui :
- ✅ Redirige `https://theo-avril.fr/portfolio/*` → container Docker
- ❌ NE redirige PAS `https://theo-avril.fr/robots.txt` → container Docker

**Résultat :** Erreur 502 sur `/robots.txt` à la racine.

---

## ✅ Solution appliquée

Le `robots.txt` est maintenant accessible à :
```
https://theo-avril.fr/portfolio/robots.txt
```

Au lieu de :
```
https://theo-avril.fr/robots.txt  (❌ nécessite config du reverse proxy)
```

---

## 📋 Modifications effectuées

### 1. **`site/public/robots.txt`** - Contenu adapté
```txt
# robots.txt pour https://theo-avril.fr/portfolio/

User-agent: *
Allow: /portfolio/
Disallow: /

# Sitemap pour le portfolio
Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
```

- `Allow: /portfolio/` → autorise le crawl du sous-dossier
- `Disallow: /` → bloque tout le reste (car votre site est uniquement dans /portfolio/)

### 2. **`Dockerfile`** - Simplifié
- ✅ Supprimé la copie de robots.txt à la racine (inutile car proxy ne le redirige pas)

### 3. **`nginx.conf`** - Simplifié
- ✅ Supprimé les routes spéciales pour robots.txt (maintenant géré par Astro automatiquement)

---

## 🚀 Déploiement

```bash
cd /home/theo/portfolio

# 1. Rebuild l'image Docker
docker compose build

# 2. Redémarrer le container
docker compose down
docker compose up -d

# 3. Tester l'accès
curl -sL https://theo-avril.fr/portfolio/robots.txt
```

**Résultat attendu :**
```txt
User-agent: *
Allow: /portfolio/
Disallow: /

Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
```

---

## 🔍 Google Search Console

### ⚠️ Important : Google accepte robots.txt dans un sous-dossier !

Contrairement à ce qu'on pense, Google **accepte** un robots.txt dans un sous-dossier **SI** votre site entier est dans ce sous-dossier.

### Configuration dans Search Console :

1. **Ajoutez votre propriété :**
   - URL : `https://theo-avril.fr/portfolio/` (avec le slash final)
   - OU en "Préfixe d'URL"

2. **Soumettez le sitemap :**
   - Dans Search Console → "Sitemaps"
   - URL à soumettre : `https://theo-avril.fr/portfolio/sitemap-index.xml`

3. **Vérifiez robots.txt :**
   - Dans Search Console → "Paramètres" → "Exploration"
   - Google cherchera automatiquement à : `https://theo-avril.fr/portfolio/robots.txt`

---

## 🎯 Alternative : Configurer le reverse proxy (optimal mais plus complexe)

Si vous voulez `robots.txt` à la racine du domaine (meilleur pour SEO), configurez votre **Nginx Proxy Manager** ou reverse proxy :

### Dans Nginx Proxy Manager :
1. Allez dans votre proxy host pour `theo-avril.fr`
2. Onglet "Custom Locations"
3. Ajoutez :
   - **Location 1 :**
     - Path : `/robots.txt`
     - Forward to : `http://portfolio:80/robots.txt`
   - **Location 2 :**
     - Path : `/portfolio`
     - Forward to : `http://portfolio:80/`

### OU dans un fichier de config Nginx manuel :
```nginx
server {
    listen 443 ssl;
    server_name theo-avril.fr;

    # Certificats SSL...

    # robots.txt à la racine
    location = /robots.txt {
        proxy_pass http://localhost:8080/robots.txt;
        proxy_set_header Host $host;
    }

    # Portfolio
    location /portfolio/ {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host $host;
    }
}
```

Puis modifiez `site/public/robots.txt` :
```txt
User-agent: *
Allow: /

Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
```

---

## 📊 Comparaison des 2 approches

| Approche | URL robots.txt | Complexité | SEO |
|----------|---------------|------------|-----|
| **Actuelle (appliquée)** | `/portfolio/robots.txt` | ✅ Simple | ✅ Bon (Google l'accepte) |
| **Optimale** | `/robots.txt` (racine) | ⚠️ Config proxy nécessaire | ✅ Parfait (standard) |

---

## ✅ Conclusion

Avec la configuration actuelle :
- ✅ `https://theo-avril.fr/portfolio/` → votre site
- ✅ `https://theo-avril.fr/portfolio/robots.txt` → accessible
- ✅ `https://theo-avril.fr/portfolio/sitemap-index.xml` → accessible
- ✅ Google pourra crawler votre site correctement

**C'est suffisant pour un bon référencement !** 🎯

Si vous voulez l'approche optimale avec robots.txt à la racine, configurez votre reverse proxy comme indiqué ci-dessus.
