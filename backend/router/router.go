package router

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"

	"github.com/usatyo/sugomori/controller"
)

func Routing() {
	e := echo.New()

	e.Use(middleware.Logger())

	e.GET("/", controller.HealthCheck)

	// GetVideos という名前だが、bodyに Joseki を含むので、POSTメソッドで受け取る
	e.POST("/video", controller.GetVideos)

	e.GET("/ranking", controller.GetRanking)

	e.POST("/joseki", controller.PostJoseki)

	err := e.Start(":8080")
	if err != nil {
		panic(err)
	}
}