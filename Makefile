NAME = fabiosartori/openldap-alpine-server
VERSION = 0.0.1

.PHONY: all build build-nocache

all: create-docker-volume build

build:
	docker build -t $(NAME):$(VERSION) --rm .

build-nocache:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .

create-docker-volume:
	docker volume inspect openldap_volume || docker volume create openldap_volume

