package test

import (
	"altares/pkg"
	"log/slog"
	"math/rand"
	"os"
	"time"

	"github.com/jaswdr/faker"
)

var Fake faker.Faker

func init() {
	Fake = faker.NewWithSeed(rand.NewSource(time.Now().UnixNano()))
}

func FakeBucketName() string {
	bucketName := ""
	for len(bucketName) <= 3 {
		bucketName = Fake.Lorem().Word()
	}
	return bucketName
}

func CreateRandomFile() *os.File {
	return CreateRandomFileWithContent(Fake.Lorem().Text(1024))
}

func CreateRandomFileWithContent(content string) *os.File {
	temp, err := os.CreateTemp(os.TempDir(), "fake_*")
	pkg.ManageError(err, "erreur à la création du fichier temporaire")
	err = os.WriteFile(temp.Name(), []byte(content), 666)
	pkg.ManageError(err, "erreur à l'écriture du fichier temporaire", slog.Any("file", temp))
	return temp
}
