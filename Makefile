COMPOSE     = docker-compose -f srcs/docker-compose.yml

BUILD       = $(COMPOSE) build --parallel --no-cache

UP          = $(COMPOSE) up -d

DOWN        = $(COMPOSE) down -v

RESTART     = $(COMPOSE) down && $(COMPOSE) up -d

SERVICES    = mariadb nginx wordpress
BONUS_SERVICES = adminer ftpserver 

all: create build-core up-core

create:
	mkdir -p /home/lagea/data/mariadb
	mkdir -p /home/lagea/data/wordpress

build:
	$(BUILD)

build-core:
	$(COMPOSE) build --no-cache $(SERVICES)

build-bonus:
	$(COMPOSE) build --no-cache $(BONUS_SERVICES)

up:
	$(UP)

up-core:
	$(COMPOSE) up -d $(SERVICES)

up-bonus:
	$(COMPOSE) up -d $(BONUS_SERVICES)

down:
	$(DOWN)

restart:
	$(RESTART)

clean:
	$(DOWN) --volumes
	docker rmi -f $$(docker images -a -q)

logs:
	$(COMPOSE) logs -f

bonus: build-bonus up-bonus
	docker exec inception_wordpress  wp redis enable

static : 
	docker stop inception_mariadb
	docker stop inception_wordpress
	$(COMPOSE) build --parallel --no-cache static
	$(COMPOSE) up -d static

re: clean all

.PHONY: all create build up down restart clean logs re bonus
