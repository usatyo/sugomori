package controller

import (
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/service"
)

func GetVideos(c echo.Context) error {
	var request model.Joseki
	if err := c.Bind(&request); err != nil {
		return c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Code: 400,
			Message: "Invalid request",
		})
	}
	videos := service.GetVideos(request)
	data := model.VideoResponse{
		Code: 200,
		Data: videos,
	}
	return c.JSON(http.StatusOK, data)
}

func GetRanking(c echo.Context) error {
	limit, err := strconv.Atoi(c.QueryParam("limit"))
	if err != nil {
		panic(err)
	}
	res := service.GetRanking(limit)
	data := model.RankingResponse {
		Code: 200,
		Data: res,
	}
	return c.JSON(http.StatusOK, data)
}

func PostJoseki(c echo.Context) error {
	var request model.JosekiPostRequest
	if err := c.Bind(&request); err != nil {
		return c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Code: 400,
			Message: "Invalid request",
		})
	}
	if len(request.Joseki.Stones) == 0 {
		return c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Code: 400,
			Message: "At least 1 stones are required",
		})
	}
	service.PostJoseki(request.Joseki, request.Video)
	data := model.HelloResponse{
		Code: 200,
		Message: "Joseki added",
	}
	return c.JSON(http.StatusOK, data)
}
