package db

import (
	"github.com/neo4j/neo4j-go-driver/v5/neo4j"
	"github.com/usatyo/sugomori/model"
)

func GetVideosFromHash(hash int64, hop int, limit int) []model.Video {
	query := `
		MATCH (s:Stone {hash: $hash})
		WITH s
		SET s.count = s.count + 1
		WITH s
		CALL apoc.neighbors.byhop(s, "Move|Relate", $hop)
		YIELD nodes
		RETURN nodes
	`
	res, err := neo4j.ExecuteQuery(Ctx, Driver,
		query,
		map[string]any {"hash": hash, "hop": hop},
		neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("neo4j"))
	if err != nil {
		panic(err)
	}
	return convertToVideoList(res, limit)
}

func GetJosekiPath(hash int64) []model.Stone {
	query := `
		MATCH path=(:Stone {hash: 0})-[:Move*]->(:Stone {hash: $hash})
		WITH reduce(output = [], n IN nodes(path) | output + n ) as nodeCollection
		UNWIND nodeCollection as collection
		RETURN distinct collection
	`
	res, err := neo4j.ExecuteQuery(Ctx, Driver,
		query,
		map[string]any {"hash": hash},
		neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("neo4j"))
	if err != nil {
		panic(err)
	}
	return convertToJoseki(res).Stones
}

func GetCountRanking(limit int) []model.Stone {
	query := `
		MATCH (s:Stone)
		ORDER BY s.count DESC
		LIMIT $limit
		RETURN s
	`
	res, err := neo4j.ExecuteQuery(Ctx, Driver,
		query,
		map[string]any {"limit": limit},
		neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("neo4j"))
	if err != nil {
		panic(err)
	}
	var stones []model.Stone
	for _, item := range res.Records {
		record, flag := item.Get("s")
		if !flag {
			continue
		}
		node := record.(neo4j.Node)
		props := node.Props
		stones = append(stones, model.Stone{
			X: int(props["x"].(int64)),
			Y: int(props["y"].(int64)),
			Color: model.Color(props["color"].(int64)),
			Hash: props["hash"].(int64),
		})
	}
	return stones
}

func CreateVideoNode(video model.Video, last model.Stone) {
	query := `
		MERGE (s:Stone {x: $x, y: $y, color: $color, hash: $hash})
		ON CREATE SET s.count = 0
		MERGE (v:Video {videoId: $videoId})
		MERGE (s)-[:Relate]->(v)
	`
	neo4j.ExecuteQuery(Ctx, Driver, query,
		map[string]any{
			"x": last.X,
			"y": last.Y,
			"color": last.Color,
			"hash": last.Hash,
			"videoId": video.Id,
		},
	neo4j.EagerResultTransformer,
	neo4j.ExecuteQueryWithDatabase("neo4j"))
}
		
func CreateJosekiNodes(joseki model.Joseki) {
	query := `
		UNWIND $stones AS item
		MERGE (s1:Stone {x: item.fromX, y: item.fromY, color: item.fromColor, hash: item.fromHash})
		ON CREATE SET s1.count = 0
		MERGE (s2:Stone {x: item.toX, y: item.toY, color: item.toColor, hash: item.toHash})
		ON CREATE SET s2.count = 0
		MERGE (s1)-[:Move]->(s2)
	`
	neo4j.ExecuteQuery(Ctx, Driver, query,
		map[string]any{"stones": convertToPathMap(joseki)},
		neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("neo4j"))
}
