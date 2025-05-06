FROM golang:1.24

WORKDIR /app

ENV TZ=Asia/Tokyo

COPY ./go.mod ./
COPY ./go.sum ./

RUN go mod download

COPY ./ ./

# CMD ["go", "run", "./cmd/api"]

SHELL ["/bin/bash", "-c"]
