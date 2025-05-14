package model

type HelloResponse struct {
	Code int    `json:"code"`
	Message string `json:"message"`
}

type VideoResponse struct {
	Code int 	   `json:"code"`
	Data []Video `json:"data"`
}

type RankingResponse struct {
	Code int		`json:"code"`
	Data []RankingData `json:"data"`
}

type RankingData struct {
	Stones []Stone `json:"stones"`
	Count int `json:"count"`
}

type ErrorResponse struct {
	Code int 	`json:"code"`
	Message string `json:"message"`
}

type JosekiPostRequest struct {
	Joseki Joseki `json:"joseki"`
	Video  Video   `json:"video"`
}