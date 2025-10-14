#!/bin/bash

# Script de vérification de l'environnement

echo "🔍 Vérification de l'environnement portfolio..."
echo ""

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Compteur
ERRORS=0

# Fonction de vérification
check() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
        ((ERRORS++))
    fi
}

# Vérifier Docker
docker --version &> /dev/null
check $? "Docker installé"

# Vérifier Docker Compose (v1 ou v2)
if docker-compose --version &> /dev/null || docker compose version &> /dev/null; then
    check 0 "Docker Compose installé"
else
    check 1 "Docker Compose installé"
fi

# Vérifier que le dossier site existe
[ -d "site" ]
check $? "Dossier 'site' présent"

# Vérifier package.json
[ -f "site/package.json" ]
check $? "package.json présent"

# Vérifier Dockerfile
[ -f "Dockerfile" ]
check $? "Dockerfile présent"

# Vérifier docker-compose.yml
[ -f "docker-compose.yml" ]
check $? "docker-compose.yml présent"

# Vérifier nginx.conf
[ -f "nginx.conf" ]
check $? "nginx.conf présent"

# Vérifier deploy.sh
[ -f "deploy.sh" ]
check $? "deploy.sh présent"

# Vérifier que deploy.sh est exécutable
[ -x "deploy.sh" ]
check $? "deploy.sh exécutable"

# Vérifier astro.config.mjs
[ -f "site/astro.config.mjs" ]
check $? "astro.config.mjs présent"

# Vérifier le port 8080
if command -v netstat &> /dev/null; then
    netstat -tuln | grep -q ":8080 "
    if [ $? -eq 0 ]; then
        echo -e "${YELLOW}⚠${NC} Port 8080 déjà utilisé (vous devrez peut-être changer le port)"
    else
        echo -e "${GREEN}✓${NC} Port 8080 disponible"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ Tout est prêt pour le déploiement !${NC}"
    echo ""
    echo "Pour déployer, exécutez :"
    echo -e "${YELLOW}./deploy.sh${NC}"
else
    echo -e "${RED}❌ $ERRORS erreur(s) détectée(s)${NC}"
    echo ""
    echo "Veuillez corriger les erreurs ci-dessus avant de déployer."
    exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
