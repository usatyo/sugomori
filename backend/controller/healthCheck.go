package controller

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/usatyo/sugomori/model"
)

func HealthCheck(c echo.Context) error {
	data := model.HelloResponse{
		Code:    200,
		Message: "OK",
	}
	return c.JSON(http.StatusOK, data)
}
