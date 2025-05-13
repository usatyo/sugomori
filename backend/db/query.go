package db

import (
	"github.com/neo4j/neo4j-go-driver/v5/neo4j"
	"github.com/usatyo/sugomori/model"
)

func PostStoneNode() {}
func PostVideoNode() {}

func GetNodes(hash int64, limit int) {
	neo4j.ExecuteQuery(Ctx, Driver,
		"MATCH (s:Stone {x: 2}) CALL apoc.neighbors.byhop(s, \"Move\", 1) YIELD nodes RETURN nodes",
		map[string]any {"hash": hash},
		neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("neo4j"))
}

func CreateNode(stone model.Stone) {
	neo4j.ExecuteQuery(Ctx, Driver,
		`MERGE (s:Stone {x: $x, y: $y, color: $color, hash: $hash}) 
			ON CREATE SET s.count = 0 
			ON MATCH SET s.count = s.count + 1`,
		map[string]any {
			"x": stone.X,
			"y": stone.Y,
			"color": stone.Color,
			"hash": stone.Hash,
		},
		neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("neo4j"))
}

func CreateEdge(from model.Stone, to model.Stone) {
	neo4j.ExecuteQuery(Ctx, Driver,
		`MATCH (s1:Stone {x: $fromX, y: $fromY, color: $fromColor, hash: $fromHash}), 
			(s2:Stone {x: $toX, y: $toY, color: $toColor, hash: $toHash}) 
			MERGE (s1)-[:Move]->(s2)`,
		map[string]any {
			"fromX": from.X,
			"fromY": from.Y,
			"fromColor": from.Color,
			"fromHash": from.Hash,
			"toX": to.X,
			"toY": to.Y,
			"toColor": to.Color,
			"toHash": to.Hash,
		},
		neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("neo4j"))
}
