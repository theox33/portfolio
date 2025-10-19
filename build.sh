#!/bin/bash

# Script de build pour le portfolio avec correction du robots.txt

echo "📦 Building Astro site..."
cd /home/theo/portfolio/site
npm run build

echo "📄 Copying robots.txt to root..."
# Copier robots.txt à la racine de dist pour qu'il soit accessible à /robots.txt
if [ -f "public/robots.txt" ]; then
    cp public/robots.txt dist/robots.txt
    echo "✅ robots.txt copied to dist/"
else
    echo "❌ Error: public/robots.txt not found"
    exit 1
fi

echo "✅ Build complete!"
echo ""
echo "📋 Next steps:"
echo "1. Rebuild Docker image: docker-compose build"
echo "2. Restart container: docker-compose up -d"
echo "3. Test robots.txt: curl http://localhost:8080/robots.txt"
echo "4. Test sitemap: curl http://localhost:8080/portfolio/sitemap-index.xml"
