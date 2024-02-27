# Traitement des fichiers siren

Ce script permet d'extraire les données de la base [sirene](https://www.data.gouv.fr/fr/datasets/base-sirene-des-entreprises-et-de-leurs-etablissements-siren-siret/) nécessaires aux traitements de l'algo de détection.

Il faut lui fournir 3 fichiers dans un répertoire dont le chemin est à passer en paramètre :
- `sireneUL.csv`
- `StockEtablissement_utf8_geo.csv`
- `StockEtablissementHistorique_utf8.csv`

En sortie il produira deux fichiers contenant uniquement les données nécessaires :
- `sirene_categories.csv`
- `sirene_dates.csv`

## Exécution
```bash
podman run -v path/to/input/files:/input -v path/to/output/files:/output sirene-data-extractor
```

__ATTENTION :__ 
  - le temps d'exécution oscille entre 30' et plus d'1h selon la machine utilisée
  - au moins 20Go de mémoire sont nécessaires pour traiter l'ensemble des données
