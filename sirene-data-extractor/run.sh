#! /usr/bin/env bash

# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't hide errors within pipes
set -o pipefail

function main() {
  log "vérifie la présence des fichiers requis"
  requirements=("/data/sireneUL.csv" "/data/StockEtablissement_utf8_geo.csv" "/data/StockEtablissementHistorique_utf8.csv")
  for fichier in "${requirements[@]}"; do
      assert_file_exist "${fichier}"
      local resultat=$?

      # Vérification de la valeur de retour
      if [ $resultat -eq 1 ]; then
          exit 1
      fi
  done

  log "lance l'extraction des catégories sirene"
  python extract_sirene_categorical.py \
  --ul_file /data/sireneUL.csv \
  --et_file /data/StockEtablissement_utf8_geo.csv \
  --output_file /data/sirene_intermediaire.csv

  log "lance l'extraction des dates sirene"
  python extract_sirene_dates.py \
  --categorical_data /data/sirene_intermediaire.csv \
  --et_hist_file /data/StockEtablissementHistorique_utf8.csv \
  --output_file /data/sirene.csv

  log "supprime le fichier intermédiaire"
  rm -f /data/sirene_intermediaire.csv
}

function assert_file_exist() {
  fichier="$1"
  log "Vérifie la présence du fichier '${fichier}'"
  if [ -r "$fichier" ]; then
      return 0  # Succès
  fi
  log "Le fichier '${fichier}' n'est pas lisible ou n'existe pas."
  return 1  # Erreur
}

function log() {
    printf '%s\n' "extraction des infos siren - $(date +%F_%T.%N) : $*"
}

main "${@}"
