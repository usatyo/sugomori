package main

import (
	"github.com/labstack/echo/v4"
	"github.com/usatyo/sugomori/controller"
)

func main() {
	e := echo.New()

	e.GET("/", controller.Hello)
	e.GET("/joseki/:id", controller.GetJoseki)
	e.POST("/joseki", controller.PostJoseki)

	e.Start(":8080")
}
