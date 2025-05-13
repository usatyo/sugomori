package service

import (
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/model"
)

func PostJoseki(joseki model.Joseki, videoId string) {
	var prev model.Stone = model.Stone{X: -1, Y: -1, Color: model.Black, Hash: 0}
	db.CreateNode(prev)
	for _, stone := range joseki.Stones {
		db.CreateNode(stone)
		db.CreateEdge(prev, stone)
		prev = stone
	}
}
