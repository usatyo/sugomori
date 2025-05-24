package model

type HelloResponse struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

type VideoResponse struct {
	Code int         `json:"code"`
	Data []VideoData `json:"data"`
}

type RankingResponse struct {
	Code int           `json:"code"`
	Data []RankingData `json:"data"`
}

type ErrorResponse struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

type JosekiPostRequest struct {
	Joseki JosekiData `json:"joseki"`
	Video  VideoData  `json:"video"`
}

type RankingData struct {
	Stones []StoneData `json:"stones"`
	Count  int         `json:"count"`
}

type StoneData struct {
	Color int   `json:"color"`
	X     int   `json:"x"`
	Y     int   `json:"y"`
	Hash  int64 `json:"hash"`
}

type JosekiData struct {
	Stones []StoneData `json:"stones"`
}

type VideoData struct {
	Id string `json:"id"`
}
