package util_test

import (
	"math/rand"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/util"
)

func generateStones(random *rand.Rand) []model.Stone {
	n := random.Intn(30) + 1
	stones := make([]model.Stone, n)
	for range n {
		stones = append(stones, model.Stone{
			X:     random.Intn(model.BoardSize),
			Y:     random.Intn(model.BoardSize),
			Color: model.Color(random.Intn(2)),
			Hash:  0,
		})
	}
	return stones
}

func equalJoseki(a, b model.Joseki) bool {
	if len(a.Stones) != len(b.Stones) {
		return false
	}
	for i := range a.Stones {
		if a.Stones[i].X != b.Stones[i].X || a.Stones[i].Y != b.Stones[i].Y || a.Stones[i].Color != b.Stones[i].Color {
			return false
		}
	}
	return true
}

func TestSameJosekiHash(t *testing.T) {
	random := rand.New(rand.NewSource(0))
	for range 10000 {
		stones := generateStones(random)
		joseki1 := model.Joseki{
			Stones: stones,
		}
		joseki2 := model.Joseki{
			Stones: stones,
		}

		util.JosekiHash(&joseki1)
		util.JosekiHash(&joseki2)

		// Assertions
		assert.Equal(t, joseki1.Stones[len(joseki1.Stones)-1].Hash, joseki2.Stones[len(joseki2.Stones)-1].Hash)
	}
}

func TestDifferentJosekiHash(t *testing.T) {
	random := rand.New(rand.NewSource(0))
	for range 10000 {
		stones1 := generateStones(random)
		stones2 := generateStones(random)
		joseki1 := model.Joseki{
			Stones: stones1,
		}
		joseki2 := model.Joseki{
			Stones: stones2,
		}

		util.JosekiHash(&joseki1)
		util.JosekiHash(&joseki2)

		if equalJoseki(joseki1, joseki2) {
			continue // Skip if the josekis are equal
		}
		// Assertions
		assert.NotEqual(t, joseki1.Stones[len(joseki1.Stones)-1].Hash, joseki2.Stones[len(joseki2.Stones)-1].Hash)
	}
}
