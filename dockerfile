# Étape 1 : Utiliser une image légère de Node.js
FROM node:18-alpine AS builder

# Étape 2 : Définir le répertoire de travail
WORKDIR /app

# Étape 3 : Copier uniquement les fichiers de dépendances
COPY package.json package-lock.json ./

# Étape 4 : Installer les dépendances
RUN npm i

# Étape 5 : Copier le reste du code source
COPY . .

# Étape 6 : Utiliser une image plus légère pour exécuter l'application
FROM node:18-alpine

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement les fichiers nécessaires depuis l’étape précédente
COPY --from=builder /app ./

# Exposer le port 8080
EXPOSE 8080

# Lancer l'application 
CMD ["npm", "start"]
