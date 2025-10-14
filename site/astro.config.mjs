import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

// Astro configuration
export default defineConfig({
  integrations: [
    tailwind({
      applyBaseStyles: false
    })
  ],
  site: 'https://yourdomain.example.com', // replace with your domain
  markdown: {
    shikiConfig: {
      theme: 'github-dark',
    },
  },
});
