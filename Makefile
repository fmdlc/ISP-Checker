.PHONY: default install start stop restart prune

NAME=ISP-Checker
VERSION=1.2
AUTHOR="Facu de la Cruz <fmdlc.unix@gmail.com>"

COMPOSE_FILE="./docker-compose/docker-compose.yaml"

default:
	@echo "USAGE: make <TARGET>"
	@echo ""
	@echo "\t- install     : Bootstrap components in docker-compose"
	@echo "\t- kube-install: Bootstrap components in K8s cluster."
	@echo "\t- start       : Start entire stack."
	@echo "\t- stop        : Stops entire stack."
	@echo "\t- restart     : Restart stack.\n"

install:
	$(info Make: Creating persistent Docker volumes)
	@bash ./docker-compose/bin/inject_credentials.sh
	@docker volume create --name=influxdb-storage
	@docker volume create --name=grafana-storage

	@docker-compose -f $(COMPOSE_FILE) up -d
	@sleep 10

	$(info Make: Initializing datasources and dashboards)
	@docker run --network host -v "$(PWD)/grafana:/app" --rm curlimages/curl:7.73.0 \
		-s --location -XPOST 'http://admin:admin@127.0.0.1:3000/api/datasources' \
		--header 'Content-Type: application/json' -d @/app/datasource.json > /dev/null

	@docker run --network host -v "$(PWD)/grafana:/app" --rm curlimages/curl:7.73.0 \
		-s --location -XPOST 'http://admin:admin@127.0.0.1:3000/api/dashboards/db' \
		--header 'Content-Type: application/json' -d @/app/network-dashboard.json > /dev/null

	@docker run --network host -v "$(PWD)/grafana:/app" --rm curlimages/curl:7.73.0 \
		-s --location -XPOST 'http://admin:admin@127.0.0.1:3000/api/dashboards/db' \
		--header 'Content-Type: application/json' -d @/app/raspberry-dashboard.json > /dev/null

	@docker run --network host -v "$(PWD)/grafana:/app" --rm curlimages/curl:7.73.0 \
		-s --location -XPUT 'http://admin:admin@127.0.0.1:3000/api/user/preferences' \
		--header 'Content-Type: application/json' -d @/app/default.json > /dev/null

	@echo "\nOpen your browser a points to http://127.0.0.1:3000/\n"
	@echo "Default Username: admin | Default Password: admin"
	@echo "Updated credentials after your first login!."
	$(info Make: Bootstrap done)

kube-install:
	kubectl apply -f https://raw.githubusercontent.com/fmdlc/ISP-Checker/master/kubernetes/ISP-Checker-deploy.yaml

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
