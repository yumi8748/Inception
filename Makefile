all:

up:
    docker-compose -f srcs/docker-compose.yml up --build

down:
    docker-compose -f srcs/docker-compose.yml down

stop:
    docker-compose -f srcs/docker-compose.yml stop

start:
    docker-compose -f srcs/docker-compose.yml start

status:
    docker ps

clean:
    docker-compose -f srcs/docker-compose.yml down -v
    docker system prune -af