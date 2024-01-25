# Traitement des fichiers siren

Ce script permet d'extraire les données sirene nécessaires au traitement de l'algo de détection.
Il faut lui fournir 3 fichiers dans un répertoire dont le chemin est à passer en paramètre :
- sireneUL.csv
- StockEtablissement_utf8_geo.csv
- StockEtablissementHistorique_utf8.csv

## Exécution, il faut copier les fichiers de données dans le répertoire

Exemple de logs du premier traitement sur un Mac Book Pro avec 16Go dont 15 alloués à Docker
```bash
import pandas as pd
2024-01-24 16:54:53,017 - DEBUG - parse les arguments
2024-01-24 16:54:53,018 - DEBUG - lit les établissements
2024-01-24 17:13:00,233 - DEBUG - parse les unités légales
2024-01-24 17:13:00,835 - DEBUG - Keep only head office
2024-01-24 17:14:46,046 - DEBUG - Export dans /data/sortie_intermediaire.csv
```

Exemple de logs du premier traitement sur un Mac Book Pro avec 16Go dont 15 alloués à Docker
```bash
import pandas as pd
2024-01-24 18:24:30,265 - DEBUG - parse les arguments
2024-01-24 18:24:30,268 - DEBUG - lit le fichier /data/StockEtablissementHistorique_utf8.csv
2024-01-24 18:32:26,302 - DEBUG - manipule les données
2024-01-24 18:36:42,459 - DEBUG - lit le fichier /data/sortie_intermediaire.csv
2024-01-24 18:36:42,809 - DEBUG - merge les fichiers
2024-01-24 18:38:53,924 - DEBUG - Export dans /data/sortie_finale.csv
```
