import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import icon from 'astro-icon';
import sitemap from '@astrojs/sitemap';

// Astro configuration
export default defineConfig({
  integrations: [
    tailwind({
      applyBaseStyles: false
    }),
    icon(),
    sitemap()
  ],
  site: 'https://theo-avril.fr', // Votre domaine
  base: '/', // Servir à la racine
  markdown: {
    shikiConfig: {
      theme: 'github-dark',
    },
  },
});
