package router

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/go-playground/validator/v10"

	"github.com/usatyo/sugomori/controller"
	val "github.com/usatyo/sugomori/validator"
)

func Routing() {
	e := echo.New()

	e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Format: "method=${method}, uri=${uri}, status=${status}\n",
	}))
	e.Use(middleware.Recover())

	e.Validator = &val.CustomValidator{Validator: validator.New()}

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
