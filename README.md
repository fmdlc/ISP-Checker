# ISP-Checker

`docker-compose` stack to run a set of ISP controls in a [Raspberry Pi](https://www.raspberrypi.org/).

[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/fmdlc)  [![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/fmdlc)
### Configuration

Make sure you have [Docker-CE](https://phoenixnap.com/kb/docker-on-raspberry-pi) installed in your *Raspberry Pi*. If you don't, install it.
```bash
$ curl -fsSL https://get.docker.com -o get-docker.sh | bash -
```

Configure the InfluxDB credentials using Environment variables in the `./docker-compose.yaml` file.
```yaml
services:
  influxdb:
    container_name: influxdb
    image: influxdb:latest
    expose:
      - 8086
    user: root
    restart: on-failure
    volumes:
      - "influxdb-storage:/var/influxdb/data"
    environment:
      - INFLUXDB_DB="db1"
      - INFLUXDB_ADMIN_USER="telegraf"
      - INFLUXDB_ADMIN_PASSWORD="VerySecurePassword"
      - INFLUXDB_READ_USER="grafana"
      - INFLUXDB_READ_USER_PASSWORD="VerySecurePassword"
```

### Start
1. Create the Docker persistent volumes running the `./create-volumes.sh`.
2. Start the stack running `docker-compose up -d`.
3. Monitor the log status with `docker-compose logs -f`.

### Login
1. Open your browser and point to `http://<RASPBERRY_IP>:3000/` and login with username `admin` and password `admin`. _Change it inmediately after the first login_.
2. Configure the _InfluxDB_ datasource to point to your local InfluxDB database.
3. Import the JSON Dashboard located in the `./grafana` directory.
![InfluxDB](./img/InfluxDB-config.png.png)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[Apache 2](https://www.apache.org/licenses/LICENSE-2.0)
