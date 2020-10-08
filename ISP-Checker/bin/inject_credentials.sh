#!/bin/bash

source ./credentials.env
cat > ./grafana/datasource.json <<EOF
{
  "access": "proxy",
  "basicAuth": false,
  "database": "${INFLUXDB_DB}",
  "isDefault": true,
  "name": "InfluxDB",
  "password": "${INFLUXDB_READ_USER_PASSWORD}",
  "type": "influxdb",
  "url": "http://influxdb:8086",
  "user": "${INFLUXDB_READ_USER}"
}
EOF

exit $?
