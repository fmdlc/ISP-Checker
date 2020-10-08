# ISP-Checker
![License](https://img.shields.io/github/license/fmdlc/ISP-Checker) ![LastCommit](https://img.shields.io/github/last-commit/fmdlc/ISP-Checker) ![Docker](https://img.shields.io/badge/Docker-19.03.13-blue)

> A `docker-compose` stack to run a set of ISP controls and collect metrics on a [Raspberry Pi](https://www.raspberrypi.org/).

[Fibertel](http://www.fibertel.com/), the most popular Argentinian Internet provider always has connectivity issues. It inspired me to use a Raspberry Pi and build some type of monitoring to aggregate metrics. I have been using [Grafana](http://grafana.com) at work for several years, so why not using the same logic?. 

`ISP-Checker` implements a set of [Telegraf](https://github.com/influxdata/telegraf) checks that sends metrics to [InfluxDB](https://www.influxdata.com/) (a OpenSource, time series based database) and runs several kind of metrics collectors to get average/aggregation/integral of values at first glance and focusing on  service quality. 

`ISP-Checker` tries to test things like _ICMP packet loss_, the average time for _DNS queries resolution_, _HTTP Response times_, _ICMP latencies_, _ICMP Standard Deviation_, _Upload/Download speed_ (by using [Speedtest-cli](https://github.com/sivel/speedtest-cli)) and a Graphical _MTR/Traceroute_ version. 

It's easily extensible and it was built on top of [Docker](http://docker.com) to make it portable and easy to run everywhere, importing automatically all components needed to perform checks.

Feel free to reach me out for any feedback or ideas! :-) 

<center>

![Demo](./img/demo.gif)

</center>

[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/fmdlc)  [![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/fmdlc)
### Configuration

Make sure you have the [Docker-CE](https://phoenixnap.com/kb/docker-on-raspberry-pi) and [cURL](https://curl.haxx.se/) installed on your *Raspberry Pi*. If you don't, install it using your prefer method.
```bash
$ curl -fsSL https://get.docker.com -o get-docker.sh | bash -
```

#### Preflight setup
Configure the `./ISP-Checker/credentials.env` file.
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

If your primary interface is not named `eth0` please take note of the right name and update it on demand by running the following command:
```
~/ISP_monitor/ISP-Checker$: sed -i 's/eth0/<YOUR-INTERFACE-NAME>/gi' grafana/network-dashboard.json
```
For example, if your Interface is called `wlan0`:
```bash
~/ISP_monitor/ISP-Checker$: sed -i 's/eth0/wlan0/gi' grafana/network-dashboard.json
```

#### Installation
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

#### Login
Open your browser and point to `http://<RASPBERRY_IP>:3000/`. Login with username `admin` and password `admin`.
_Change it inmediately after the first login_.

#### Removing
Be sure you completelly understand what `prune` Makefile action implies (For more details check the `Makefile`). 
To remove run `make prune`.
 
> It will remove all stopped containers (yes, not only the ISP-Checker ones). 

## ToDo
- [ ] Allows users to select their metrics endpoint.
- [ ] Allow users to select their Grafana Org.
- [ ] Helm Chart to run in Kubernetes.
- [ ] Enable HTTPS support.
- [ ] Enable Interfaces configuration.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
ISP-Checker is licensed under [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license.
