#!/bin/sh

set -e
set -x

repo=${1:-github.com/drone-plugins/drone-docker}

# compile the main binary
GOOS=linux GOARCH=amd64 CGO_ENABLED=0         go build -ldflags "-X main.build=${DRONE_BUILD_NUMBER}" -a -tags netgo -o release/linux/amd64/drone-docker ${repo}/cmd/drone-docker
GOOS=linux GOARCH=arm64 CGO_ENABLED=0         go build -ldflags "-X main.build=${DRONE_BUILD_NUMBER}" -a -tags netgo -o release/linux/arm64/drone-docker ${repo}/cmd/drone-docker
GOOS=linux GOARCH=arm   CGO_ENABLED=0 GOARM=7 go build -ldflags "-X main.build=${DRONE_BUILD_NUMBER}" -a -tags netgo -o release/linux/arm/drone-docker   ${repo}/cmd/drone-docker

# build the heroku binary
GOOS=linux GOARCH=amd64 CGO_ENABLED=0         go build -a -tags netgo -o release/linux/amd64/drone-docker-heroku ${repo}/cmd/drone-docker-heroku
GOOS=linux GOARCH=arm64 CGO_ENABLED=0         go build -a -tags netgo -o release/linux/arm64/drone-docker-heroku ${repo}/cmd/drone-docker-heroku
GOOS=linux GOARCH=arm   CGO_ENABLED=0 GOARM=7 go build -a -tags netgo -o release/linux/arm/drone-docker-heroku   ${repo}/cmd/drone-docker-heroku

# build the gcr binary
GOOS=linux GOARCH=amd64 CGO_ENABLED=0         go build -a -tags netgo -o release/linux/amd64/drone-docker-gcr ${repo}/cmd/drone-docker-gcr
GOOS=linux GOARCH=arm64 CGO_ENABLED=0         go build -a -tags netgo -o release/linux/arm64/drone-docker-gcr ${repo}/cmd/drone-docker-gcr
GOOS=linux GOARCH=arm   CGO_ENABLED=0 GOARM=7 go build -a -tags netgo -o release/linux/arm/drone-docker-gcr   ${repo}/cmd/drone-docker-gcr

# build the ecr binary
GOOS=linux GOARCH=amd64 CGO_ENABLED=0         go build -a -tags netgo -o release/linux/amd64/drone-docker-ecr ${repo}/cmd/drone-docker-ecr
GOOS=linux GOARCH=arm64 CGO_ENABLED=0         go build -a -tags netgo -o release/linux/arm64/drone-docker-ecr ${repo}/cmd/drone-docker-ecr
GOOS=linux GOARCH=arm   CGO_ENABLED=0 GOARM=7 go build -a -tags netgo -o release/linux/arm/drone-docker-ecr   ${repo}/cmd/drone-docker-ecr
