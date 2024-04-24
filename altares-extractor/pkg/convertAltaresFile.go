package pkg

import (
	"encoding/csv"
	"golang.org/x/text/encoding/charmap"
	"io"
	"log/slog"
	"os"

	"github.com/pkg/errors"
)

var mappingStock = mapping{
	siren:                           noOpConversion(1),
	etat_organisation:               noOpConversion(3),
	code_paydex:                     noOpConversion(4),
	nbr_jrs_retard:                  noOpConversion(5),
	nbr_fournisseurs:                noOpConversion(6),
	encours_etudies:                 noOpConversion(7),
	note_100_alerteur_plus_30:       noOpConversion(9),
	note_100_alerteur_plus_90_jours: noOpConversion(10),
	date_valeur:                     advancedConversion(11 /*datifyStock*/, fakeDate),
}

func ConvertAltaresFile(altaresFile string, output io.Writer) {
	slog.Info("conversion du fichier stock", slog.String("filename", altaresFile))
	inputFile, err := os.Open(altaresFile)
	if err != nil {
		panic(err)
	}
	defer func() {
		closeErr := inputFile.Close()
		if closeErr != nil {
			panic(errors.Wrap(closeErr, "erreur à la fermeture du fichier"))
		}
	}()
	//inputFileWithoutBOM, encoding := utfbom.Skip(inputFile)
	//slog.Info("encodage du fichier stock détecté", slog.String("encoding", encoding.String()))
	reader := csv.NewReader(charmap.ISO8859_15.NewDecoder().Reader(inputFile))
	reader.TrimLeadingSpace = true
	reader.Comma = ';'

	w := csv.NewWriter(output)
	defer w.Flush()

	readAllRows(reader, w, mappingStock, true)
}

func datifyStock(s string) string {
	if len(s) != 10 {
		slog.Warn("format de la date inconnu " + s)
	}
	return s[6:10] + "-" + s[3:5] + "-" + s[0:2]
}

func fakeDate(s string) string {
	return "yyyy-mm-dd"
}
