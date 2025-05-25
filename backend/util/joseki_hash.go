package util

import (
	"math/rand"

	"github.com/usatyo/sugomori/model"
)

var table = generateArray()

func generateArray() [][][]int64 {
	random := rand.New(rand.NewSource(0))
	ret := make([][][]int64, model.BoardSize+1)
	for i := range model.BoardSize + 1 {
		ret[i] = make([][]int64, model.BoardSize+1)
		for j := range model.BoardSize + 1 {
			ret[i][j] = make([]int64, model.All*2)
			for k := range model.All * 2 {
				ret[i][j][k] = random.Int63()
			}
		}
	}
	return ret
}

func JosekiHash(joseki *model.Joseki) {
	*joseki = GetNormalizedJoseki(*joseki)
	stones := &((*joseki).Stones)
	val := int64(0)
	for i := range *stones {
		if (*stones)[i].X == -1 && (*stones)[i].Y == -1 {
			val = val ^ table[model.BoardSize][model.BoardSize][i]
		} else if (*stones)[i].Color == model.Black {
			val = val ^ table[(*stones)[i].X][(*stones)[i].Y][i]
		} else {
			val = val ^ table[(*stones)[i].X][(*stones)[i].Y][i+model.All]
		}
		(*stones)[i].Hash = val
	}
}

func New(stones []model.Stone) *model.Joseki {
	joseki := model.Joseki{
		Stones: stones,
	}
	JosekiHash(&joseki)
	return &model.Joseki{
		Stones: stones,
	}
}
