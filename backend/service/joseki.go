package service

import (
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/model"
)

func PostJoseki(joseki model.Joseki, video model.Video) {
	db.CreateVideoNode(video, joseki.Stones[len(joseki.Stones) - 1])
	db.CreateJosekiNodes(joseki.Stones)
}


