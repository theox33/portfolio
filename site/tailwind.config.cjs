/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.{astro,html,js,jsx,ts,tsx}',
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: {
          light: '#6EE7B7',
          DEFAULT: '#34D399',
          dark: '#059669',
        },
        secondary: {
          light: '#93C5FD',
          DEFAULT: '#3B82F6',
          dark: '#1D4ED8',
        },
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
};
