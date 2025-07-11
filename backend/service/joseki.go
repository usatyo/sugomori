package service

import (
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/util"
)

// API の型定義で受け取って、API の型定義で返す

func GetVideos(josekiData model.JosekiData) []model.VideoData {
	joseki := josekiData.ToModel()
	util.JosekiHash(&joseki)
	db.CreateJosekiNodes(joseki)
	var targetHash int64 = 0
	if len(joseki.Stones) > 0 {
		targetHash = joseki.Stones[len(joseki.Stones)-1].Hash
	}
	videos := db.GetVideosFromHash(targetHash, 8, 5)
	var videoDatas []model.VideoData
	for _, video := range videos {
		videoDatas = append(videoDatas, video.ToData())
	}
	return videoDatas
}

func GetRanking(limit int) []model.RankingData {
	if limit == 0 {
		limit = 10
	}
	rankings := db.GetCountRanking(limit)
	var result []model.RankingData

	// TODO: 動的に取得する
	count := 10

	for _, ranking := range rankings {
		joseki := db.GetJosekiPath(ranking.Hash)
		result = append(result, model.RankingData{
			Stones: joseki.ToData().Stones,
			Count:  &count,
		})
	}
	return result
}

func PostJoseki(josekiData model.JosekiData, videoData model.VideoData) {
	joseki := josekiData.ToModel()
	video := videoData.ToModel()
	util.JosekiHash(&joseki)
	db.CreateVideoNode(video, joseki.Stones[len(joseki.Stones)-1])
	db.CreateJosekiNodes(joseki)
}

func GetJoseki(videoId string) []model.JosekiData {
	joseki := db.GetJosekiList(videoId)
	josekiData := make([]model.JosekiData, 0, len(joseki))
	for _, j := range joseki {
		josekiData = append(josekiData, j.ToData())
	}
	return josekiData
}

func DeleteJoseki(josekiData model.JosekiData, videoData model.VideoData) {
	joseki := josekiData.ToModel()
	video := videoData.ToModel()
	util.JosekiHash(&joseki)
	db.DeleteRelation(video, joseki)
}
