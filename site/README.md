# 🚀 Portfolio Moderne - Théo AVRIL

Portfolio personnel conçu avec **Astro**, **Tailwind CSS**, et **GSAP** pour des animations époustouflantes.

## ✨ Fonctionnalités

### 🎨 Design & UI
- **Hero Section spectaculaire** avec :
  - Gradients animés en arrière-plan
  - Particules flottantes
  - Avatar avec effet de glow pulsant
  - Boutons CTA avec effet magnétique
  - Texte en dégradé animé

### 🎭 Animations & Interactions
- **GSAP avancé** :
  - Animations parallax sur le scroll
  - Effets de reveal progressif des sections
  - Animations staggered pour les éléments
  - Effets de tilt 3D sur les cartes de projets
  - Effets magnétiques sur les boutons

- **Curseur personnalisé** :
  - Curseur avec effet de suivi fluide
  - Agrandissement au survol des éléments interactifs

### 🔮 Effets Visuels Modernes
- **Glass Morphism** : Effet de verre sur les cartes et composants
- **Gradients animés** : Transitions de couleurs fluides
- **Backdrop blur** : Flou d'arrière-plan sophistiqué
- **Hover effects** : Transformations 3D, ombres dynamiques, échelle

### 📊 Sections Interactives

#### Navigation
- Barre de navigation avec effet blur
- Indicateur de progression du scroll
- Mise en évidence automatique du lien actif
- Menu mobile responsive

#### Compétences
- Barres de progression animées
- Icônes de technologies (via Iconify)
- Effet de brillance au survol
- Pourcentages de maîtrise

#### Projets
- Cartes avec effet 3D tilt au survol
- Gradient overlay animé
- Badges de technologies avec effet glow
- Liens externes avec indicateurs

#### Contact
- Cartes de contact avec icônes
- Effets de hover sophistiqués
- Bouton CTA avec effet magnétique

### ⚡ Performance & SEO
- **View Transitions** natives d'Astro
- **Sitemap** automatique
- **Icônes optimisées** avec astro-icon
- **Images optimisées** dans le dossier public

## 🛠️ Technologies Utilisées

- **[Astro](https://astro.build)** - Framework web moderne
- **[Tailwind CSS](https://tailwindcss.com)** - Framework CSS utility-first
- **[GSAP](https://greensock.com/gsap/)** - Bibliothèque d'animations
- **[Astro Icon](https://www.astroicon.dev/)** - Intégration d'icônes
- **[Iconify](https://iconify.design/)** - Collection d'icônes

## 🚀 Démarrage

### Installation
```bash
npm install
```

### Développement
```bash
npm run dev
```
Le site sera accessible sur `http://localhost:4321`

### Build Production
```bash
npm run build
```

### Prévisualisation
```bash
npm run preview
```

## 📁 Structure du Projet

```
site/
├── public/
│   └── images/           # Images statiques
├── src/
│   ├── components/       # Composants Astro
│   │   ├── About.astro
│   │   ├── Contact.astro
│   │   ├── Footer.astro
│   │   ├── Header.astro
│   │   ├── NavBar.astro
│   │   ├── ProjectCard.astro
│   │   ├── Projects.astro
│   │   └── Skills.astro
│   ├── content/          # Données JSON
│   │   ├── profile.json
│   │   └── projects.json
│   ├── layouts/
│   │   └── Layout.astro  # Layout principal
│   ├── pages/
│   │   └── index.astro   # Page d'accueil
│   ├── scripts/
│   │   └── animations.js # Animations GSAP
│   └── styles/
│       └── global.css    # Styles globaux
└── astro.config.mjs      # Configuration Astro
```

## 🎨 Personnalisation

### Modifier les informations personnelles
Éditez `src/content/profile.json` :
```json
{
  "name": "Votre Nom",
  "tagline": "Votre titre",
  "about": "Votre description",
  "skills": [...],
  "contact": {...}
}
```

### Ajouter des projets
Éditez `src/content/projects.json` :
```json
[
  {
    "title": "Nom du projet",
    "description": "Description",
    "technos": ["Tech1", "Tech2"],
    "link": "https://...",
    "image": "/images/projet.png"
  }
]
```

### Modifier les couleurs
Les couleurs principales sont définies dans les classes Tailwind :
- `purple-*` : Couleur primaire
- `pink-*` : Couleur secondaire
- `blue-*` : Couleur d'accent

## 🎯 Optimisations

- ✅ Animations GPU-accelerated (GSAP)
- ✅ Lazy loading des images
- ✅ Code splitting automatique (Astro)
- ✅ CSS optimisé (Tailwind)
- ✅ View Transitions natives
- ✅ Sitemap pour SEO

## 📝 Licence

MIT © 2025 Théo AVRIL

---

Fait avec ❤️ et [Astro](https://astro.build)
