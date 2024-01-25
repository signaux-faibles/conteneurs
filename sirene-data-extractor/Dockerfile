# Utilise une image de base avec Python
FROM python:3.9

# Défini le répertoire de travail dans le conteneur
WORKDIR /app

RUN pip install --upgrade pip

# Installe les dépendances, y compris pandas
RUN pip install --no-cache-dir pandas

# Copie le reste de l'application dans le conteneur
COPY python/* /app/
COPY run.sh /app

# Rend le script exécutable
RUN chmod +x run.sh

# Définissez la commande à exécuter au démarrage du conteneur
CMD ["./run.sh"]


