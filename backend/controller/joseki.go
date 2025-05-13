package controller

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func GetJoseki(c echo.Context) error {
	return c.String(http.StatusOK, "Hello")
}

func PostJoseki(c echo.Context) error {
	return c.String(http.StatusOK, "Hello")
}
