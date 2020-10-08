# ISP-Checker
`docker-compose` stack to run a set of ISP controls in a [Raspberry Pi](https://www.raspberrypi.org/).

<center>
	
![Demo](./img/demo.gif)

</center>

[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/fmdlc)  [![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/fmdlc)
### Configuration

Make sure you have [Docker-CE](https://phoenixnap.com/kb/docker-on-raspberry-pi) installed in your *Raspberry Pi*. If you don't, install it.
```bash
$ curl -fsSL https://get.docker.com -o get-docker.sh | bash -
```

Start setting up the `./ISP-Checker/credentials.env` file, configuring the InfluxDB database name and their credentials.
There are two users: 
* <ins>Read-Only user:</ins> Used by Grafana to acccess to metrics
* <ins>Read and Write user:</ins> Used by Telegraf to write metrics into the InfluxDB Database.

```bash
$: cat ./ISP-Checker/credentials.env

#--------------------------------------------------
# Setup here credentials for InfluxDB and Telegraf
#--------------------------------------------------
## InfluxDB database name
INFLUXDB_DB=telegraf

## InfluxDB admin credentials
INFLUXDB_ADMIN_USER=root
INFLUXDB_ADMIN_PASSWORD=VerySecurePassword

## Read Only user for Grafana
INFLUXDB_READ_USER=grafana
INFLUXDB_READ_USER_PASSWORD=VerySecurePassword
```

Go to the `./ISP-Checker` directory, see the Makefile on this directory.

```bash
$: make
USAGE: make <TARGET>

	- install: Bootstrap components.
	- start  : Start entire stack.
	- stop   : Stops entire stack.
	- restart: Restart stack.
```

Execute `make install` to install.

```bash
$: cd ./ISP-Checker/
$: make install
```

### Login
Open your browser and point to `http://<RASPBERRY_IP>:3000/` and login with username `admin` and password `admin`. 
_Change it inmediately after the first login_.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[Apache 2](https://www.apache.org/licenses/LICENSE-2.0)
