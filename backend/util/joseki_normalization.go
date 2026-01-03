package util

import (
	"slices"

	"github.com/usatyo/sugomori/model"
)

// 向き・白黒を正規化（辞書順）
// 最初の手抜きを削除

func GetNormalizedJoseki(joseki model.Joseki) model.Joseki {
	if len(joseki.Stones) == 0 {
		return joseki
	}
	if joseki.Stones[0].Color == model.White {
		joseki = getReversedJoseki(joseki)
	}

	for variant := range 8 {
		joseki = min(joseki, GetVariousJoseki(joseki, variant))
	}

	for i := range len(joseki.Stones) {
		if isSymmetric(joseki.Stones[:i+1]) {
			originalJoseki := model.Joseki{Stones: joseki.Stones[i+1:]}
			backJoseki := min(originalJoseki, getSymmetricJoseki(originalJoseki))
			joseki = model.Joseki{
				Stones: append(joseki.Stones[:i+1], backJoseki.Stones...),
			}
		}
	}
	
	return joseki
}

func isSymmetric(stones []model.Stone) bool {
	for _, stone := range stones {
		if stone.X == stone.Y {
			continue
		}
		if !slices.Contains(stones, model.Stone{Color: stone.Color, X: stone.Y, Y: stone.X}) {
			return false
		}
	}
	return true
}

func GetVariousJoseki(joseki model.Joseki, variant int) model.Joseki {
	if variant < 4 {
		joseki = getSymmetricJoseki(joseki)
	}
	for range variant % 4 {
		joseki = getRotatedJoseki(joseki)
	}
	return joseki
}

func getSymmetricJoseki(joseki model.Joseki) model.Joseki {
	var stones []model.Stone
	for _, stone := range joseki.Stones {
		stones = append(stones, model.Stone{
			Color: stone.Color,
			X:     stone.Y,
			Y:     stone.X,
			Hash:  0,
		})
	}
	return model.Joseki{
		Stones: stones,
	}
}

func getRotatedJoseki(joseki model.Joseki) model.Joseki {
	var stones []model.Stone
	for _, stone := range joseki.Stones {
		stones = append(stones, model.Stone{
			Color: stone.Color,
			X:     model.BoardSize - stone.Y - 1,
			Y:     stone.X,
			Hash:  0,
		})
	}
	return model.Joseki{
		Stones: stones,
	}
}

func getReversedJoseki(joseki model.Joseki) model.Joseki {
	var stones []model.Stone
	for _, stone := range joseki.Stones {
		stones = append(stones, model.Stone{
			Color: GetReversedColor(stone.Color),
			X:     stone.X,
			Y:     stone.Y,
			Hash:  0,
		})
	}
	return model.Joseki{
		Stones: stones,
	}
}

func GetReversedColor(color model.Color) model.Color {
	if color == model.Black {
		return model.White
	}
	return model.Black
}

func min(joseki1, joseki2 model.Joseki) model.Joseki {
	array1 := toArray(joseki1)
	array2 := toArray(joseki2)
	for i := 0; i < len(array1) && i < len(array2); i++ {
		if array1[i] < array2[i] {
			return joseki1
		} else if array1[i] > array2[i] {
			return joseki2
		}
	}
	return joseki1
}

func toArray(joseki model.Joseki) []int {
	var array []int
	for _, stone := range joseki.Stones {
		array = append(array, int(stone.Color), int(stone.X), int(stone.Y))
	}
	return array
}
