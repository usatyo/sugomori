FROM golang:1.24

WORKDIR /app

ENV TZ=Asia/Tokyo

COPY backend/go.mod .
COPY backend/go.sum .

RUN go mod download

COPY ./backend .

# CMD ["go", "run", "./cmd/api"]

SHELL ["/bin/bash", "-c"]
