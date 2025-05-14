package main

import (
	"github.com/labstack/echo/v4"
	"github.com/usatyo/sugomori/controller"
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/util"
)

func main() {
	util.LoadEnv()
	db.Initialize()
	
	e := echo.New()

	e.GET("/", controller.HealthCheck)
	e.GET("/video", controller.GetVideos)
	e.GET("/ranking", controller.GetRanking)
	e.POST("/joseki", controller.PostJoseki)

	e.Start(":8080")
}
