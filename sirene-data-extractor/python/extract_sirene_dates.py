"""Extract head office activity dates from sirene databases.

The expected input databases are:
- The `StockEtablissementHistorique` sirene file.
- The output of `extract_sirene_categorical.py` : a merge of some of `StockEtablissement`
 and `StockUniteLegale` fields.

See the argument parser help.

This script extract dates intervals during which companies are known to be active.

See https://www.data.gouv.fr/fr/datasets/base-sirene-des-entreprises-et-de-leurs-etablissements-siren-siret/
for more info.
"""

import argparse

import pandas as pd
import logging

# Configurer le système de logs (peut être fait une seule fois)
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')


logging.debug('parse les arguments')
parser = argparse.ArgumentParser("Extract sirene data")
parser.add_argument(
    "--categorical_data",
    dest="CATEGORICAL_DATA",
    help="Previous merge of sirene databases.",
)
parser.add_argument(
    "--et_hist_file",
    dest="ET_HIST_FILE",
    help="StockEtablissementHistorique database.",
)
parser.add_argument("-o", "--output_file", dest="OUTPUT_FILE")
args = parser.parse_args()

logging.debug(f'lit le fichier {args.ET_HIST_FILE}')
df_et_hist = pd.read_csv(
    args.ET_HIST_FILE,
    usecols=[
        "siret",
        "etatAdministratifEtablissement",
        "dateDebut",
        "dateFin",
    ],
    dtype={
        "siret": str,
        "etatAdministratifEtablissement": "category",
        "dateDebut": str,
        "dateFin": str,
    },
    memory_map=True,
).rename(
    columns={
        "etatAdministratifEtablissement": "état_actif",
        "dateFin": "date_fin",
        "dateDebut": "date_début",
    },
)


logging.debug('manipule les données')
df_et_hist = df_et_hist.dropna(subset=["date_début"])  # Entreprise purgée
df_et_hist = df_et_hist.dropna(subset=["état_actif"])

# Filter on activity status and parse dates
df_et_hist["état_actif"] = df_et_hist["état_actif"].map({"A": True, "F": False})
df_et_hist = df_et_hist.loc[df_et_hist["état_actif"]].drop(
    columns=["état_actif"], axis=1
)
df_et_hist["date_début"] = pd.to_datetime(
    df_et_hist["date_début"], format="%Y-%m-%d", errors="coerce"
)
df_et_hist["date_fin"] = pd.to_datetime(
    df_et_hist["date_fin"], format="%Y-%m-%d", errors="coerce"
)

logging.debug(f'lit le fichier {args.CATEGORICAL_DATA}')
# Load head office info from first extraction and merge with date info
df_et_ul = pd.read_csv(
    args.CATEGORICAL_DATA,
    dtype={
        "siren": "str",
        "siret": "str",
    },
    usecols=["siren", "siret"],
)

logging.debug('merge les fichiers')
df_dates = pd.merge(df_et_ul, df_et_hist, on="siret", how="inner").drop(
    columns=["siret"]
)

# Export
logging.debug(f'Export dans {args.OUTPUT_FILE}')
df_dates.set_index("siren").to_csv(
    args.OUTPUT_FILE,
)
