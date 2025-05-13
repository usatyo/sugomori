package main

import (
	// "github.com/labstack/echo/v4"
	// "github.com/usatyo/sugomori/controller"
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/model"
	"github.com/usatyo/sugomori/service"
	"github.com/usatyo/sugomori/util"
)

func main() {
	util.LoadEnv()
	db.Initialize()
	var tsukehiki []model.Stone
	tsukehiki = append(tsukehiki, model.Stone{Color: model.Black, X: 2, Y: 3, Hash: 0})
	tsukehiki = append(tsukehiki, model.Stone{Color: model.Black, X: 4, Y: 3, Hash: 0})
	tsukehiki = append(tsukehiki, model.Stone{Color: model.Black, X: 4, Y: 2, Hash: 0})
	tsukehiki = append(tsukehiki, model.Stone{Color: model.Black, X: 5, Y: 2, Hash: 0})
	tsukehiki = append(tsukehiki, model.Stone{Color: model.Black, X: 3, Y: 2, Hash: 0})
	tsukehiki = append(tsukehiki, model.Stone{Color: model.Black, X: 5, Y: 3, Hash: 0})
	tsukehiki = append(tsukehiki, model.Stone{Color: model.Black, X: 3, Y: 5, Hash: 0})

	service.PostJoseki(*util.New(tsukehiki), "test")

	// e := echo.New()

	// e.GET("/", controller.Hello)
	// e.GET("/joseki", controller.GetJoseki)
	// e.POST("/joseki", controller.PostJoseki)

	// e.Start(":8080")
}
