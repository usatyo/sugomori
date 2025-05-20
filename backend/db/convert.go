package db

import (
	"github.com/neo4j/neo4j-go-driver/v5/neo4j"
	"github.com/neo4j/neo4j-go-driver/v5/neo4j/dbtype"
	"github.com/usatyo/sugomori/model"
)

func convertToVideoList(res *neo4j.EagerResult, limit int) []model.Video {
	var videos []model.Video
	for _, item := range res.Records {
		record, flag := item.Get("nodes")
		if !flag {
			continue
		}
		for _, node := range record.([]any) {
			props := node.(neo4j.Node).Props
			if props["videoId"] == nil || limit <= len(videos) {
				continue
			}
			videos = append(videos, model.Video{
				Id: props["videoId"].(string),
			})
		}
	}
	return videos
}

func convertToJoseki(res *neo4j.EagerResult) model.Joseki {
	var joseki model.Joseki = model.Joseki{
		Stones: []model.Stone{},
	}
	for _, item := range res.Records {
		record, flag := item.Get("collection")
		if !flag {
			continue
		}
		props := record.(dbtype.Node).Props
		joseki.Stones = append(joseki.Stones, model.Stone{
			X:     int(props["x"].(int64)),
			Y:     int(props["y"].(int64)),
			Color: model.Color(props["color"].(int64)),
			Hash:  props["hash"].(int64),
		})
	}
	return joseki
}

func convertToPathMap(joseki model.Joseki) []map[string]any {
	var result []map[string]any
	prev := model.Stone{X: -1, Y: -1, Color: -1, Hash: 0}
	for _, stone := range joseki.Stones {
		result = append(result, map[string]any{
			"fromX":     prev.X,
			"fromY":     prev.Y,
			"fromColor": prev.Color,
			"fromHash":  prev.Hash,
			"toX":       stone.X,
			"toY":       stone.Y,
			"toColor":   stone.Color,
			"toHash":    stone.Hash,
		})
		prev = stone
	}
	return result
}
