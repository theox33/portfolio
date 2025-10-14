#!/bin/bash

# Script de déploiement du portfolio

echo "🚀 Démarrage du déploiement du portfolio..."

# Couleurs pour les messages
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Détecter la commande docker-compose
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
elif docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    echo -e "${RED}❌ Docker Compose n'est pas installé${NC}"
    exit 1
fi

# Arrêter et supprimer l'ancien conteneur
echo -e "${BLUE}📦 Arrêt des conteneurs existants...${NC}"
$DOCKER_COMPOSE down

# Rebuilder l'image Docker
echo -e "${BLUE}🔨 Build de l'image Docker...${NC}"
$DOCKER_COMPOSE build --no-cache

# Démarrer le nouveau conteneur
echo -e "${BLUE}▶️  Démarrage du conteneur...${NC}"
$DOCKER_COMPOSE up -d

# Vérifier que le conteneur tourne
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Déploiement réussi !${NC}"
    echo -e "${GREEN}🌐 Le site est accessible sur http://localhost:8080/portfolio/${NC}"
    echo ""
    echo "📊 Logs du conteneur :"
    $DOCKER_COMPOSE logs -f
else
    echo -e "${RED}❌ Erreur lors du déploiement${NC}"
    exit 1
fi
