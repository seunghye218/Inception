name = j_inception

all:
#mkdir -p ${HOME}/data/wordpress ${HOME}/data/mariadb
	mkdir -p ./data/wordpress ./data/mariadb
	docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build --force-recreate

build:
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	docker compose -f ./srcs/docker-compose.yml stop

start:
	docker compose -f ./srcs/docker-compose.yml start

restart:
	docker compose -f ./srcs/docker-compose.yml restart

logs:
	docker compose -f ./srcs/docker-compose.yml logs


clean: down
	docker-compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans

fclean: clean
	rm -rf ./data
	#rm -f .setup
	docker system prune --volumes --all --force
	docker network prune --force
	docker volume prune --force

re: fclean all

.PHONY: all build down re clean fclean start stop restart
