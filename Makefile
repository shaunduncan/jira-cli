.PHONY: all build install test testv clean

PROGRAM_NAME=jira
CGO_ENABLED?=1
VERSION?=$(shell git describe --always)
BUILD_DIR?=$(PWD)/build

all: build

build:
	mkdir -p $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(PROGRAM_NAME) -ldflags "-linkmode external -s -w -X main.Version=$(VERSION)"

install: build
	cp $(BUILD_DIR)/$(PROGRAM_NAME) ~/bin/$(PROGRAM_NAME)

test:
	@go clean -testcache
	go test -short -failfast -timeout=120s -race ./...

testv:
	@go clean -testcache
	go test -short -failfast -timeout=120s -race -v ./...
