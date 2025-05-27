package controller_test

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/go-playground/validator/v10"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
	"github.com/usatyo/sugomori/controller"
	"github.com/usatyo/sugomori/db"
	"github.com/usatyo/sugomori/util"
	val "github.com/usatyo/sugomori/validator"
)

var (
	RequestPostJosekiJSON = `{
		"joseki": {"stones": [
			{"x": 3, "y": 2, "color": 0},
			{"x": 3, "y": 4, "color": 1},
			{"x": 2, "y": 4, "color": 0},
			{"x": 2, "y": 3, "color": 1}
		]},
		"video": {"id": "aj0I_Z6bK9E"}
	}`
	ResponsePostJosekiJSON = `{"message":"Joseki added"}` + "\n"
)

func TestPostJoseki200(t *testing.T) {
	util.LoadEnvVar("../.env.dev")
	db.Initialize()

	e := echo.New()
	e.Validator = &val.CustomValidator{Validator: validator.New()}
	req := httptest.NewRequest(http.MethodPost, "/joseki", strings.NewReader(RequestPostJosekiJSON))
	req.Header.Set(echo.HeaderContentType, echo.MIMEApplicationJSON)
	rec := httptest.NewRecorder()
	c := e.NewContext(req, rec)

	// Assertions
	if assert.NoError(t, controller.PostJosekiHandler(c)) {
		assert.Equal(t, http.StatusOK, rec.Code)
		assert.Equal(t, ResponsePostJosekiJSON, rec.Body.String())
	}
}

var (
	RequestGetVideoJSON = `{
		"stones": [
			{"x": 3, "y": 2, "color": 0},
			{"x": 3, "y": 4, "color": 1},
			{"x": 2, "y": 4, "color": 0},
			{"x": 2, "y": 3, "color": 1}
		]
	}`
	ResponseGetVideoJSON = `{"data":[{"id":"aj0I_Z6bK9E"}]}` + "\n"
)

func TestGetVideo200(t *testing.T) {
	util.LoadEnvVar("../.env.dev")
	db.Initialize()

	e := echo.New()
	e.Validator = &val.CustomValidator{Validator: validator.New()}
	req := httptest.NewRequest(http.MethodPost, "/video", strings.NewReader(RequestGetVideoJSON))
	req.Header.Set(echo.HeaderContentType, echo.MIMEApplicationJSON)
	rec := httptest.NewRecorder()
	c := e.NewContext(req, rec)

	// Assertions
	if assert.NoError(t, controller.GetVideoHandler(c)) {
		assert.Equal(t, http.StatusOK, rec.Code)
		assert.Equal(t, ResponseGetVideoJSON, rec.Body.String())
	}
}
