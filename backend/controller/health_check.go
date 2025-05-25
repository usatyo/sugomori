package controller

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/usatyo/sugomori/model"
)

func HealthCheckHandler(c echo.Context) error {
	return c.JSON(http.StatusOK, model.HelloResponse{
		Message: "OK",
	})
}
