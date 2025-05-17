package util

import "github.com/usatyo/sugomori/model"

// 向き・白黒を正規化（辞書順）
// 最初の手抜きを削除

func GetNormalizedJoseki(joseki model.Joseki) model.Joseki {
	joseki = removeFirstPass(joseki)
	var options []model.Joseki = []model.Joseki{
		joseki,
		getReversedJoseki(joseki),
		getSymmetricJoseki(joseki),
		getReversedJoseki(getSymmetricJoseki(joseki)),
	}
	var minJoseki model.Joseki = joseki
	for _, option := range options {
		minJoseki = min(minJoseki, option)
	}
	return minJoseki
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

func removeFirstPass(joseki model.Joseki) model.Joseki {
	var stones []model.Stone
	for _, stone := range joseki.Stones {
		if stone.X == -1 && stone.Y == -1 {
			continue
		}
		stones = append(stones, stone)
	}
	return model.Joseki{
		Stones: stones,
	}
}
