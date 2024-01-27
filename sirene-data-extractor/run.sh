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
  TEMP_FILE=sirene_intermediaire.csv
  OUTPUT_FILE=sirene_dates.csv

  log "fichier intermédiaire -> ${TEMP_FILE}"
  log "fichier de sortie -> ${OUTPUT_FILE}"

  log "lance l'extraction des catégories sirene"
  python extract_sirene_categorical.py \
  --ul_file /input/sireneUL.csv \
  --et_file /input/StockEtablissement_utf8_geo.csv \
  --output_file /ouput/${TEMP_FILE}

  log "lance l'extraction des dates sirene"
  python extract_sirene_dates.py \
  --categorical_data /output/${TEMP_FILE} \
  --et_hist_file /input/StockEtablissementHistorique_utf8.csv \
  --output_file /output/${OUTPUT_FILE}

  log "supprime le fichier intermédiaire"
  rm -f /output/${TEMP_FILE}
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
