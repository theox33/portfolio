#!/bin/bash

# Script de backup du portfolio

BACKUP_DIR="backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="portfolio_backup_${DATE}.tar.gz"

echo "💾 Création d'un backup du portfolio..."

# Créer le dossier de backup s'il n'existe pas
mkdir -p $BACKUP_DIR

# Créer l'archive
tar -czf "${BACKUP_DIR}/${BACKUP_NAME}" \
    --exclude='node_modules' \
    --exclude='dist' \
    --exclude='.astro' \
    --exclude='backups' \
    site/ \
    Dockerfile \
    docker-compose.yml \
    nginx.conf \
    2>/dev/null

if [ $? -eq 0 ]; then
    SIZE=$(du -h "${BACKUP_DIR}/${BACKUP_NAME}" | cut -f1)
    echo "✅ Backup créé avec succès : ${BACKUP_NAME} (${SIZE})"
    echo "📂 Emplacement : ${BACKUP_DIR}/${BACKUP_NAME}"
    
    # Garder seulement les 5 derniers backups
    ls -t ${BACKUP_DIR}/portfolio_backup_*.tar.gz | tail -n +6 | xargs -r rm
    echo "🧹 Anciens backups nettoyés (conservation des 5 derniers)"
else
    echo "❌ Erreur lors de la création du backup"
    exit 1
fi
