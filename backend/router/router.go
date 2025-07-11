package router

import (
	"github.com/go-playground/validator/v10"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"

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

	e.GET("/", controller.HealthCheckHandler)

	// GetVideos という名前だが、bodyに Joseki を含むので、POSTメソッドで受け取る
	e.POST("/video", controller.GetVideoHandler)

	e.GET("/ranking", controller.GetRankingHandler)

	e.POST("/joseki", controller.PostJosekiHandler)

	e.GET("/joseki", controller.GetJosekiHandler)

	e.DELETE("/joseki", controller.DeleteJosekiHandler)

	err := e.Start(":8080")
	if err != nil {
		panic(err)
	}
}
