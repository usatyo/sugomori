FROM golang:1.22.5

WORKDIR /app

COPY backend/go.mod .
COPY backend/go.sum .

RUN go mod download

COPY ./backend .

CMD ["go", "run", "./cmd/api"]
