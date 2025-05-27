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

func generateSkippedStones(random *rand.Rand) ([]model.Stone, []model.Stone) {
	n := random.Intn(30) + 1
	stones1 := make([]model.Stone, n)
	stones2 := make([]model.Stone, n+1)
	stones2[0] = model.Stone{
		X:     -1,
		Y:     -1,
		Color: model.Color(random.Intn(2)),
		Hash:  0,
	}
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
		stones2[i+1] = model.Stone{
			X:     x,
			Y:     y, // Skip one row
			Color: model.InversedColor(color),
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

func TestSkipped(t *testing.T) {
	random := rand.New(rand.NewSource(0))
	for range 10000 {
		stones1, stones2 := generateSkippedStones(random)
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
