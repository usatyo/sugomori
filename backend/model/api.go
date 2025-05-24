package model

type HelloResponse struct {
	Message string `json:"message"`
}

type VideoResponse struct {
	Data []VideoData `json:"data"`
}

type RankingResponse struct {
	Data []RankingData `json:"data"`
}

type ErrorResponse struct {
	Message string `json:"message"`
}

type JosekiPostRequest struct {
	Joseki JosekiData `json:"joseki"`
	Video  VideoData  `json:"video"`
}

type VideoGetRequest = JosekiData

type RankingData struct {
	Stones []StoneData `json:"stones" validate:"required,dive"`
	Count  *int         `json:"count" validate:"required,min=0"`
}

type StoneData struct {
	Color *int   `json:"color" validate:"required,oneof=0 1"`
	X     *int   `json:"x" validate:"required,min=-1,max=18"`
	Y     *int   `json:"y" validate:"required,min=-1,max=18"`
}

type JosekiData struct {
	Stones []StoneData `json:"stones" validate:"required,dive"`
}

type VideoData struct {
	Id string `json:"id"`
}
