COMPOSE     = docker-compose -f srcs/docker-compose.yml

DOWN        = $(COMPOSE) down

RESTART     = $(COMPOSE) down && $(COMPOSE) up -d

SERVICES    = mariadb nginx wordpress

all: create build-core up-core

create:
	mkdir -p /home/lagea/data/mariadb
	mkdir -p /home/lagea/data/wordpress

build-core:
	$(COMPOSE) build --no-cache $(SERVICES)

up-core:
	$(COMPOSE) up -d $(SERVICES)

down:
	$(DOWN)

restart:
	$(RESTART)

clean:
	$(DOWN) --volumes
	docker rmi -f $$(docker images -a -q)

logs:
	$(COMPOSE) logs -f

static : 
	docker stop inception_mariadb
	docker stop inception_wordpress
	$(COMPOSE) build --no-cache static
	$(COMPOSE) up -d static

re: clean all

.PHONY: all create build up down restart clean logs re bonus static
