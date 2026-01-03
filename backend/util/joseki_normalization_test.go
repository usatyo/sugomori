package util_test

import (
	"math/rand"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/util"
)

func generateSymmetricStones(random *rand.Rand) ([]model.Stone, []model.Stone) {
	n := random.Intn(30) + 1
	stones1 := make([]model.Stone, n)
	stones2 := make([]model.Stone, n)
	for i := range n {
		x := random.Intn(model.BoardSize)
		y := random.Intn(model.BoardSize)
		color := model.Color(random.Intn(2))
		stones1[i] = model.Stone{
			X:     x,
			Y:     y,
			Color: color,
			Hash:  0,
		}
		stones2[i] = model.Stone{
			X:     y,
			Y:     x,
			Color: color,
			Hash:  0,
		}
	}
	return stones1, stones2
}

func TestSymmetric(t *testing.T) {
	random := rand.New(rand.NewSource(0))
	for range 10000 {
		stones1, stones2 := generateSymmetricStones(random)
		joseki1 := model.Joseki{
			Stones: stones1,
		}
		joseki2 := model.Joseki{
			Stones: stones2,
		}

		util.JosekiHash(&joseki1)
		util.JosekiHash(&joseki2)

		// Assertions
		assert.Equal(t, joseki1.Stones[len(joseki1.Stones)-1].Hash, joseki2.Stones[len(joseki2.Stones)-1].Hash)
	}
}

func TestSymmetricInTheMiddle(t *testing.T) {
	stones := []model.Stone{
		{X: 3, Y: 3, Color: model.Black},
		{X: 2, Y: 5, Color: model.White},
		{X: 5, Y: 2, Color: model.White},
		{X: 5, Y: 3, Color: model.Black},
	}
	joseki1 := model.Joseki{
		Stones: stones,
	}
	util.JosekiHash(&joseki1)

	for variant := range 8 {
		joseki2 := util.GetVariousJoseki(joseki1, variant)
		util.JosekiHash(&joseki2)
		assert.Equal(t, joseki1.Stones[len(joseki1.Stones)-1].Hash, joseki2.Stones[len(joseki2.Stones)-1].Hash)
	}
}
