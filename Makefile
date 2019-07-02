USER := $(shell whoami)
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
DOCKER_TAG := $(USER)/innosetup:$(GIT_BRANCH)

.PHONY: build
build:
	docker build -t $(DOCKER_TAG) .

.PHONY: test
test:
	docker run --rm -i -v $(PWD):/work $(DOCKER_TAG) helloworld.iss

.PHONY: shell
shell:
	docker run --rm -it -v $(PWD):/work --entrypoint /bin/bash $(DOCKER_TAG)

.PHONY: clean
clean:
	rm -rf Output
