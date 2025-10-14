.PHONY: help build up down restart logs dev clean rebuild

help: ## Afficher l'aide
	@echo "📋 Commandes disponibles:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Builder l'image Docker
	@echo "🔨 Build de l'image Docker..."
	docker-compose build

up: ## Démarrer le conteneur en production
	@echo "▶️  Démarrage du conteneur..."
	docker-compose up -d
	@echo "✅ Site accessible sur http://localhost:8080/portfolio/"

down: ## Arrêter le conteneur
	@echo "⏹️  Arrêt du conteneur..."
	docker-compose down

restart: down build up ## Redémarrer (rebuild + up)

logs: ## Afficher les logs
	docker-compose logs -f

dev: ## Lancer le mode développement avec hot-reload
	@echo "🔧 Démarrage en mode développement..."
	docker-compose -f docker-compose.dev.yml up

dev-local: ## Lancer le dev en local (sans Docker)
	@echo "🔧 Démarrage en mode développement local..."
	cd site && npm run dev

clean: ## Nettoyer les conteneurs et images
	@echo "🧹 Nettoyage..."
	docker-compose down -v
	docker system prune -f

rebuild: clean build up ## Rebuild complet (clean + build + up)

deploy: ## Déployer (rebuild + up)
	@./deploy.sh

.DEFAULT_GOAL := help
