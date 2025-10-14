#!/bin/bash

# Script pour régénérer package-lock.json

echo "🔄 Régénération du package-lock.json..."

cd site

# Supprimer l'ancien package-lock.json
rm -f package-lock.json

# Supprimer node_modules pour être sûr
rm -rf node_modules

# Régénérer package-lock.json
npm install

echo "✅ package-lock.json régénéré avec succès !"
echo ""
echo "Vous pouvez maintenant relancer ./deploy.sh"
