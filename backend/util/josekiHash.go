package util

import (
	"math/rand"

	"github.com/usatyo/sugomori/model"
)

var table = generateArray()

func generateArray() [][][]int64 {
	random := rand.New(rand.NewSource(0))
	ret := make([][][]int64, model.BoardSize)
	for i := range model.BoardSize {
		ret[i] = make([][]int64, model.BoardSize)
		for j := range model.BoardSize {
			ret[i][j] = make([]int64, model.All * 2)
			for k := range model.All * 2 {
				ret[i][j][k] = random.Int63()
			}
		}
	}
	return ret
}

func JosekiHash(stones *[]model.Stone) {
	val := int64(0)
	for i := range *stones {
		if (*stones)[i].Color == model.Black {
			val = val ^ table[(*stones)[i].X][(*stones)[i].Y][i]
		} else {
			val = val ^ table[(*stones)[i].X][(*stones)[i].Y][i + model.All]
		}
		(*stones)[i].Hash = val
	}
}

func New(stones []model.Stone) *model.Joseki {
	JosekiHash(&stones)
	return &model.Joseki{
		Stones: stones,
	}
}
