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
  site: 'https://yourdomain.example.com', // replace with your domain
  markdown: {
    shikiConfig: {
      theme: 'github-dark',
    },
  },
});
