package main

import (
	"altares/pkg"
	"io"
	"log/slog"
	"os"
)

var loglevel *slog.LevelVar

func main() {
	input, o := readArgs()
	output, err := os.Create(o)
	pkg.ManageError(err, "erreur à la création du fichier de sortie")
	slog.Debug("fichier de sortie créé", slog.String("filename", output.Name()))
	defer pkg.CloseIt(output, "fermeture du fichier de sortie : "+o)
	convertAndConcat(input, output)
}

func convertAndConcat(altaresFile string, outputCsv io.Writer) {
	slog.Debug("démarrage de la conversion et de la concaténation", slog.Any("input", altaresFile))
	pkg.WriteHeaders(outputCsv)
	pkg.ConvertAltaresFile(altaresFile, outputCsv)
}

func readArgs() (input string, output string) {
	slog.Debug("lecture des arguments", slog.String("status", "start"), slog.Any("all", os.Args))
	if len(os.Args) != 3 {
		slog.Warn("rien à faire, car pas de fichiers altares ou pas de fichier source")
		os.Exit(0)
	}
	input = os.Args[1]
	output = os.Args[2]

	slog.Debug("lecture des arguments", slog.String("status", "end"), slog.String("output", output), slog.Any("input", input))
	return input, output
}

func init() {
	loglevel = new(slog.LevelVar)
	loglevel.Set(slog.LevelDebug)
	handler := slog.NewTextHandler(os.Stderr, &slog.HandlerOptions{
		Level: loglevel,
	})

	logger := slog.New(
		handler)
	slog.SetDefault(logger)
}
