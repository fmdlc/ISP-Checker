#!/bin/bash

 docker volume create --name=influxdb-storage
 docker volume create --name=grafana-storage

 exit $?
