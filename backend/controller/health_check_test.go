package controller_test

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
	"github.com/usatyo/sugomori/controller"
)

var (
	ResponseJSON = `{"message":"OK"}` + "\n"
)

func TestHealthCheck(t *testing.T) {
	e := echo.New()
	req := httptest.NewRequest(http.MethodGet, "/", nil)
	rec := httptest.NewRecorder()
	c := e.NewContext(req, rec)
	c.SetPath("/")

	// Assertions
	if assert.NoError(t, controller.HealthCheckHandler(c)) {
		assert.Equal(t, http.StatusOK, rec.Code)
		assert.Equal(t, ResponseJSON, rec.Body.String())
	}
}
