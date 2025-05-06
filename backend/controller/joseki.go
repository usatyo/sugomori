package controller

import (
	"fmt"
	"net/http"

	"github.com/labstack/echo/v4"
)

func GetJoseki(c echo.Context) error {
	id := c.QueryParam("id")
	fmt.Println(id)
	return c.String(http.StatusOK, "Hello")
}

func PostJoseki(c echo.Context) error {
	return c.String(http.StatusOK, "Hello")
}
