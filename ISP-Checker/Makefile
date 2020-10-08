.PHONY: default install start stop restart prune

NAME=ISP-Checker
VERSION=1.0

COMPOSE_FILE="./docker/docker-compose.yaml"

default:
	@echo "USAGE: make <TARGET>"
	@echo ""
	@echo "\t- install: Bootstrap components."
	@echo "\t- start  : Start entire stack."
	@echo "\t- stop   : Stops entire stack."
	@echo "\t- restart: Restart stack.\n"

install:
	$(info Make: Creating persistent Docker volumes)
	@docker volume create --name=influxdb-storage
	@docker volume create --name=grafana-storage

	@docker-compose -f $(COMPOSE_FILE) up -d
	@sleep 10

	$(info Make: Initializing datasources and dashboards)
	@curl -s --location --request POST 'http://admin:admin@localhost:3000/api/datasources' \
		--header 'Content-Type: application/json' \
		-d @./grafana/datasource.json > /dev/null

	@curl -s --location --request POST 'http://admin:admin@localhost:3000/api/dashboards/db' \
		--header 'Content-Type: application/json' \
		-d @./grafana/network-dashboard.json > /dev/null

	@echo "\nOpen your browser a points to http://127.0.0.1:3000/\n"
	@echo "Default Username: admin | Default Password: admin"
	@echo "Updated credentials after your first login!."
	$(info Make: Bootstrap done)

start:
	docker-compose -f $(COMPOSE_FILE) up -d

stop:
	docker-compose -f $(COMPOSE_FILE) stop

restart:
	docker-compose -f $(COMPOSE_FILE) restart

prune:
	docker-compose -f $(COMPOSE_FILE) stop
	docker rm `docker ps -a -q`
	docker volume rm influxdb-storage
	docker volume rm grafana-storage

