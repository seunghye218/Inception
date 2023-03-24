name = inception

all:
	mkdir -p /home/seunghye/data/wordpress /home/seunghye/data/mariadb /home/seunghye/data/mariadb_log
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build --force-recreate

build:
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

restart:
	docker-compose -f ./srcs/docker-compose.yml restart

logs:
	docker-compose -f ./srcs/docker-compose.yml logs

init:
	sh srcs/requirements/tools/init_script.sh

clean: down
	docker-compose -f ./srcs/docker-compose.yml down -v --rmi all --remove-orphans

fclean: clean
	sudo rm -rf /home/seunghye/data
	docker system prune --volumes --all --force
	docker network prune --force
	docker volume prune --force

re: fclean all

.PHONY: all build down re clean fclean start stop restart
