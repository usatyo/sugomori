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
	RequestPostJosekiOKJSON = `{
		"joseki": {"stones": [
			{"x": 3, "y": 2, "color": 0},
			{"x": 3, "y": 4, "color": 1},
			{"x": 2, "y": 4, "color": 0},
			{"x": 2, "y": 3, "color": 1}
		]},
		"video": {"id": "aj0I_Z6bK9E"}
	}`
	ResponsePostJosekiOKJSON = `{"message":"Joseki added"}` + "\n"
)

func TestPostJosekiOK(t *testing.T) {
	util.LoadEnvVar("../.env.dev")
	db.Initialize()

	e := echo.New()
	e.Validator = &val.CustomValidator{Validator: validator.New()}
	req := httptest.NewRequest(http.MethodPost, "/joseki", strings.NewReader(RequestPostJosekiOKJSON))
	req.Header.Set(echo.HeaderContentType, echo.MIMEApplicationJSON)
	rec := httptest.NewRecorder()
	c := e.NewContext(req, rec)

	// Assertions
	if assert.NoError(t, controller.PostJosekiHandler(c)) {
		assert.Equal(t, http.StatusOK, rec.Code)
		assert.Equal(t, ResponsePostJosekiOKJSON, rec.Body.String())
	}
}

var (
	RequestGetVideoOKJSON = `{
		"stones": [
			{"x": 3, "y": 2, "color": 0},
			{"x": 3, "y": 4, "color": 1},
			{"x": 2, "y": 4, "color": 0},
			{"x": 2, "y": 3, "color": 1}
		]
	}`
	ResponseGetVideoOKJSON = `{"data":[{"id":"aj0I_Z6bK9E"}]}` + "\n"
)

func TestGetVideoOK(t *testing.T) {
	util.LoadEnvVar("../.env.dev")
	db.Initialize()

	e := echo.New()
	e.Validator = &val.CustomValidator{Validator: validator.New()}
	req := httptest.NewRequest(http.MethodPost, "/video", strings.NewReader(RequestGetVideoOKJSON))
	req.Header.Set(echo.HeaderContentType, echo.MIMEApplicationJSON)
	rec := httptest.NewRecorder()
	c := e.NewContext(req, rec)

	// Assertions
	if assert.NoError(t, controller.GetVideoHandler(c)) {
		assert.Equal(t, http.StatusOK, rec.Code)
		assert.Equal(t, ResponseGetVideoOKJSON, rec.Body.String())
	}
}

var (
	RequestPostJosekiEmptyJSON = `{
		"joseki": {"stones": []},
		"video": {"id": "aj0I_Z6bK9E"}
	}`
	ResponsePostJosekiEmptyJSON = `{"message":"At least 1 stones are required"}` + "\n"
)

func TestPostJosekiEmpty(t *testing.T) {
	util.LoadEnvVar("../.env.dev")
	db.Initialize()

	e := echo.New()
	e.Validator = &val.CustomValidator{Validator: validator.New()}
	req := httptest.NewRequest(http.MethodPost, "/joseki", strings.NewReader(RequestPostJosekiEmptyJSON))
	req.Header.Set(echo.HeaderContentType, echo.MIMEApplicationJSON)
	rec := httptest.NewRecorder()
	c := e.NewContext(req, rec)

	// Assertions
	if assert.NoError(t, controller.PostJosekiHandler(c)) {
		assert.Equal(t, http.StatusBadRequest, rec.Code)
		assert.Equal(t, ResponsePostJosekiEmptyJSON, rec.Body.String())
	}
}
