package main

import (
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/router"
	"github.com/usatyo/sugomori/util"
)

func main() {
	util.LoadEnv()
	db.Initialize()
	router.Routing()
}
