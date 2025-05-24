package controller

import (
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/service"
)

func GetVideos(c echo.Context) error {
	var request model.VideoGetRequest
	if err := c.Bind(&request); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest)
	}
	if err := c.Validate(&request); err != nil {
		println(err.Error())
		return echo.NewHTTPError(http.StatusBadRequest)
	}
	videos := service.GetVideos(request)
	var data model.VideoResponse
	if len(videos) == 0 {
		data = model.VideoResponse{
			Data: make([]model.VideoData, 0),
		}
	} else {
		data = model.VideoResponse{
			Data: videos,
		}
	}
	return c.JSON(http.StatusOK, data)
}

func GetRanking(c echo.Context) error {
	limit, err := strconv.Atoi(c.QueryParam("limit"))
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest)
	}
	res := service.GetRanking(limit)
	data := model.RankingResponse{
		Data: res,
	}
	return c.JSON(http.StatusOK, data)
}

func PostJoseki(c echo.Context) error {
	var request model.JosekiPostRequest
	if err := c.Bind(&request); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest)
	}
	if err := c.Validate(&request); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest)
	}
	if len(request.Joseki.Stones) == 0 {
		return c.JSON(http.StatusBadRequest, model.ErrorResponse{
			Message: "At least 1 stones are required",
		})
	}
	service.PostJoseki(request.Joseki, request.Video)
	data := model.HelloResponse{
		Message: "Joseki added",
	}
	return c.JSON(http.StatusOK, data)
}
