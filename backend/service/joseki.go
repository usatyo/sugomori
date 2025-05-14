package service

import (
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/util"
)

func GetVideos(stones []model.Stone) []model.Video {
	util.JosekiHash(&stones)
	var targetHash int64 = 0
	if len(stones) > 0 {
		targetHash = stones[len(stones)-1].Hash
	}
	videos := db.GetVideosFromHash(targetHash, 8, 5)
	return videos
}

func GetRanking(limit int) []model.RankingData {
	if limit == 0 {
		limit = 10
	}
	rankings := db.GetCountRanking(limit)
	var result []model.RankingData
	for _, ranking := range rankings {
		result = append(result, model.RankingData{
			Stones: db.GetJosekiPath(ranking.Hash),
			Count:  10,
		})
	}
	return result
}

func PostJoseki(joseki model.Joseki, video model.Video) {
	util.JosekiHash(&joseki.Stones)
	db.CreateVideoNode(video, joseki.Stones[len(joseki.Stones) - 1])
	db.CreateJosekiNodes(joseki.Stones)
}


