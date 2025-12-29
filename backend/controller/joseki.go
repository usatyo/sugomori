package controller

import (
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/service"
)

func GetVideoHandler(c echo.Context) error {
	var request model.VideoGetRequest
	if err := c.Bind(&request); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError)
	}
	if err := c.Validate(&request); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError)
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

func GetRankingHandler(c echo.Context) error {
	limit, err := strconv.Atoi(c.QueryParam("limit"))
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError)
	}
	if limit <= 0 {
		return echo.NewHTTPError(http.StatusInternalServerError, "value 'limit' must be greater than 0")
	}
	if limit >= 100 {
		return echo.NewHTTPError(http.StatusInternalServerError, "value 'limit' must be less than 100")
	}
	res := service.GetRanking(limit)
	data := model.RankingResponse{
		Data: res,
	}
	return c.JSON(http.StatusOK, data)
}

func PostJosekiHandler(c echo.Context) error {
	var request model.JosekiPostRequest
	if err := c.Bind(&request); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError)
	}
	if err := c.Validate(&request); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError)
	}
	if len(request.Joseki.Stones) == 0 {
		return c.JSON(http.StatusInternalServerError, model.ErrorResponse{
			Message: "At least 1 stones are required",
		})
	}
	if len(request.Joseki.Stones) > 30 {
		return c.JSON(http.StatusInternalServerError, model.ErrorResponse{
			Message: "More than 30 stones are not allowed",
		})
	}
	if len(service.GetJoseki(request.Video.Id)) >= 5 {
		return c.JSON(http.StatusInternalServerError, model.ErrorResponse{
			Message: "More than 5 videos are not allowed",
		})
	}
	service.PostJoseki(request.Joseki, request.Video)
	data := model.MessageResponse{
		Message: "Joseki added",
	}
	return c.JSON(http.StatusOK, data)
}

func GetJosekiHandler(c echo.Context) error {
	videoId := c.QueryParam("videoId")
	joseki := service.GetJoseki(videoId)
	var data model.JosekiResponse
	if len(joseki) == 0 {
		data = model.JosekiResponse{
			Data: make([]model.JosekiData, 0),
		}
	} else {
		data = model.JosekiResponse{
			Data: joseki,
		}
	}
	return c.JSON(http.StatusOK, data)
}

func DeleteJosekiHandler(c echo.Context) error {
	var request model.JosekiPostRequest
	if err := c.Bind(&request); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError)
	}
	if err := c.Validate(&request); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError)
	}
	println("DeleteJosekiHandler called with request:", request.Video.Id)
	service.DeleteJoseki(request.Joseki, request.Video)
	return c.JSON(http.StatusOK, model.MessageResponse{
		Message: "Joseki deleted",
	})
}
