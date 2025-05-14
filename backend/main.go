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

	service.PostJoseki(*util.New(append(tsukehiki, model.Stone{Color: model.Black, X: 9, Y: 4, Hash: 0})), model.Video{Id: "tsukehiki1"})
	service.PostJoseki(*util.New(append(tsukehiki, model.Stone{Color: model.Black, X: 9, Y: 3, Hash: 0})), model.Video{Id: "tsukehiki2"})

	videos := db.GetVideosFromHash(0, 10, 3)
	for _, video := range videos {
		println(video.Id)
	}
	path := db.GetJosekiPath(3758025965957661012)
	for _, stone := range path {
		println(stone.X, stone.Y, stone.Color)
	}
	
	// e := echo.New()

	// e.GET("/", controller.Hello)
	// e.GET("/joseki", controller.GetJoseki)
	// e.POST("/joseki", controller.PostJoseki)

	// e.Start(":8080")
}
