# 🚀 Guide SEO - Portfolio de Théo AVRIL

## ✅ Optimisations techniques déjà implémentées

### 1. **Balises Meta et SEO On-Page** (`site/src/layouts/Layout.astro`)

✨ **Ce qui a été ajouté :**

- ✅ `<title>` optimisé : "Théo AVRIL - Ingénieur Systèmes Embarqués | Portfolio"
- ✅ `<meta name="description">` : description accrocheuse de 155 caractères
- ✅ `<meta name="author">` : Théo AVRIL
- ✅ `<meta name="robots">` : index, follow (autorisation explicite d'indexation)
- ✅ `<meta name="keywords">` : mots-clés ciblés (Théo AVRIL, ingénieur systèmes embarqués, C/C++, Linux embarqué, ESEO Angers, etc.)
- ✅ `<link rel="canonical">` : URL canonique pour éviter le contenu dupliqué
- ✅ **Langue** : `lang="fr"` sur la balise `<html>`

### 2. **Open Graph (partage sur réseaux sociaux)**

✨ **Balises ajoutées pour LinkedIn, Facebook, etc. :**

```html
<meta property="og:type" content="website" />
<meta property="og:title" content="..." />
<meta property="og:description" content="..." />
<meta property="og:image" content="https://theo-avril.fr/portfolio/images/avatar.png" />
<meta property="og:url" content="https://theo-avril.fr/portfolio/" />
<meta property="og:locale" content="fr_FR" />
```

**Résultat :** Quand vous partagez votre portfolio sur LinkedIn ou Facebook, vous aurez une belle carte avec votre photo, titre et description !

### 3. **Twitter Card**

✨ **Optimisation pour Twitter/X :**

```html
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="..." />
<meta name="twitter:description" content="..." />
<meta name="twitter:image" content="..." />
```

### 4. **Schema.org JSON-LD (données structurées)**

✨ **Marquage sémantique pour Google :**

Un script JSON-LD a été ajouté dans le `<head>` pour indiquer à Google :

- Votre identité : **Théo AVRIL** (Person)
- Votre métier : **Ingénieur Systèmes Embarqués**
- Vos profils sociaux : LinkedIn, GitHub
- Votre formation : ESEO Angers
- Vos langues : Français, Anglais

**Avantage :** Google comprend mieux qui vous êtes et peut afficher un **Knowledge Graph** ou une carte enrichie dans les résultats de recherche.

### 5. **Attributs `alt` des images**

✅ **Images optimisées :**

- Avatar : `"Portrait de Théo AVRIL - Ingénieur Systèmes Embarqués"`
- Projets : `"Capture d'écran du projet {titre} par Théo AVRIL"`

**Impact SEO :** Les images apparaîtront dans Google Images avec des descriptions pertinentes.

### 6. **Structure sémantique HTML**

✅ **Hiérarchie des titres :**

- `<h1>` : Votre nom complet "Théo AVRIL" (dans Header.astro)
- `<h2>` : Sections principales (Projets, Expériences, Compétences, Contact, etc.)
- `<h3>` : Sous-sections et cartes de projets

**Résultat :** Google comprend la structure logique de votre site.

### 7. **Fichier `robots.txt`**

✅ **Créé dans** `site/public/robots.txt` :

```txt
User-agent: *
Allow: /

Sitemap: https://theo-avril.fr/portfolio/sitemap-index.xml
Sitemap: https://theo-avril.fr/portfolio/sitemap-0.xml
```

**Rôle :** Indique aux moteurs de recherche où trouver votre sitemap.

### 8. **Sitemap XML**

✅ **Déjà configuré** dans `astro.config.mjs` :

```javascript
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://theo-avril.fr',
  base: '/portfolio/',
  integrations: [sitemap()]
});
```

**Résultat :** Le sitemap est généré automatiquement lors du build (`npm run build`) et sera accessible à :
- `https://theo-avril.fr/portfolio/sitemap-index.xml`

---

## 🔥 Actions à faire maintenant (côté externe)

### 1. **Soumettre le site à Google Search Console**

📌 **Étapes :**

1. Allez sur [Google Search Console](https://search.google.com/search-console/)
2. Ajoutez la propriété `https://theo-avril.fr`
3. Vérifiez la propriété (méthode recommandée : fichier HTML ou balise meta)
4. Soumettez le sitemap :
   - Cliquez sur "Sitemaps" dans le menu de gauche
   - Entrez : `portfolio/sitemap-index.xml`
   - Cliquez sur "Envoyer"
5. Demandez l'indexation de votre page principale :
   - Cliquez sur "Inspection d'URL"
   - Entrez : `https://theo-avril.fr/portfolio/`
   - Cliquez sur "Demander l'indexation"

**Délai :** Indexation sous 24-48h en général.

---

### 2. **Ajouter des backlinks (liens entrants)**

🔗 **Priorité haute :** Plus vous avez de liens de qualité pointant vers votre site, plus Google vous considère comme "légitime".

#### ✅ Actions immédiates :

1. **LinkedIn** :
   - Ajoutez le lien dans votre section "Contact" : `https://theo-avril.fr/portfolio/`
   - Ajoutez-le dans votre section "À propos" ou "En vedette"
   - Publiez un post annonçant votre portfolio avec le lien

2. **GitHub** :
   - Ajoutez le lien dans votre bio GitHub
   - Créez un README.md dans votre profil avec un lien vers votre portfolio

3. **CV PDF** :
   - Ajoutez un hyperlien cliquable vers votre site

4. **Signature email** :
   - Ajoutez le lien dans votre signature HTML

#### 🎯 Actions à moyen terme :

5. **ESEO Angers** :
   - Demandez à être ajouté sur la page des alumni ou des projets étudiants avec un lien vers votre portfolio

6. **Partenaires de stage (Thales, etc.)** :
   - Demandez à être mentionné avec un lien dans les pages projets ou équipe

7. **Blogs / articles** :
   - Si vous écrivez un article technique (Medium, Dev.to), ajoutez un lien vers votre portfolio

---

### 3. **Optimiser le contenu textuel**

📝 **Conseils pour améliorer le référencement naturel :**

#### ✅ Sections à enrichir :

1. **Section "À propos"** (`src/components/About.astro`) :
   - Ajoutez plus de texte avec des mots-clés naturels :
     - "Théo AVRIL"
     - "ingénieur systèmes embarqués"
     - "développement C/C++"
     - "Linux embarqué"
     - "ESEO Angers"
   - Parlez de vos passions, de vos projets marquants
   - Utilisez la première personne ("Je suis", "J'ai développé")

2. **Descriptions de projets** :
   - Ajoutez des détails techniques
   - Mentionnez votre nom dans certains projets
   - Ex : "Projet réalisé par Théo AVRIL dans le cadre de..."

3. **Blog (optionnel mais recommandé)** :
   - Créez une page `/blog` ou `/actualités`
   - Publiez des articles techniques sur vos projets
   - Google adore les sites qui évoluent régulièrement

---

### 4. **Vérifier la performance du site**

⚡ **Testez la vitesse et l'accessibilité :**

1. Allez sur [PageSpeed Insights](https://pagespeed.web.dev/)
2. Entrez votre URL : `https://theo-avril.fr/portfolio/`
3. Visez un score > 90 sur mobile et desktop

**Si le score est faible :**
- Optimisez les images (format WebP, compression)
- Réduisez les animations GSAP si trop lourdes
- Activez le lazy loading pour les images (déjà fait avec `loading="lazy"`)

---

### 5. **Suivi et analytics**

📊 **Installez Google Analytics (optionnel mais utile) :**

1. Créez un compte [Google Analytics 4](https://analytics.google.com/)
2. Ajoutez le script de tracking dans `Layout.astro` :

```astro
<head>
  <!-- ... autres balises ... -->
  
  <!-- Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
  <script is:inline>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-XXXXXXXXXX');
  </script>
</head>
```

**Avantage :** Vous pourrez suivre le nombre de visiteurs, les pages les plus vues, etc.

---

## 🧩 Checklist finale

### ✅ Déjà fait (code)
- [x] Balises meta optimisées (title, description, robots, keywords)
- [x] Open Graph et Twitter Card
- [x] Schema.org JSON-LD (données structurées)
- [x] Sitemap configuré
- [x] robots.txt créé
- [x] Attributs alt optimisés
- [x] Structure HTML sémantique (H1, H2, H3)
- [x] URL canonique
- [x] Langue française déclarée

### 📋 À faire maintenant (actions externes)
- [ ] Soumettre le site à Google Search Console
- [ ] Ajouter le lien sur LinkedIn (bio + post)
- [ ] Ajouter le lien sur GitHub (bio + README)
- [ ] Ajouter le lien dans la signature email
- [ ] Demander à l'ESEO d'ajouter un lien vers votre portfolio
- [ ] Publier un post LinkedIn annonçant votre portfolio
- [ ] Tester la performance sur PageSpeed Insights

### 🚀 Bonus (optionnel)
- [ ] Installer Google Analytics
- [ ] Créer une section Blog
- [ ] Ajouter une page /cv avec version PDF téléchargeable
- [ ] Demander des recommandations LinkedIn avec lien vers votre site

---

## 📈 Résultats attendus

**Dans 1 semaine :**
- Votre site sera indexé par Google
- En tapant "Théo AVRIL" → votre portfolio devrait apparaître dans les premiers résultats

**Dans 1 mois :**
- Avec des backlinks de LinkedIn, GitHub, ESEO → vous devriez être en **position 1-3** pour "Théo AVRIL"
- Début d'apparition pour "Théo AVRIL ingénieur systèmes embarqués"

**Dans 3 mois :**
- Avec du contenu régulier (blog) et plus de backlinks → visibilité accrue pour des requêtes techniques

---

## 🛠️ Commandes utiles

### Build et déploiement :

```bash
# Se placer dans le dossier site
cd /home/theo/portfolio/site

# Installer les dépendances (si pas déjà fait)
npm install

# Builder le site (génère le sitemap automatiquement)
npm run build

# Prévisualiser le build
npm run preview
```

### Vérifier le sitemap :

Après le build, le sitemap sera généré dans `dist/sitemap-index.xml` et `dist/sitemap-0.xml`.

---

## 📞 Support

Si vous avez des questions ou besoin d'aide, n'hésitez pas ! 🚀

**Bon référencement ! 🎯**
