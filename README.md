# ISP-Checker
![License](https://img.shields.io/github/license/fmdlc/ISP-Checker) ![LastCommit](https://img.shields.io/github/last-commit/fmdlc/ISP-Checker) ![Docker](https://img.shields.io/badge/Docker-19.03.13-blue)

> A `docker-compose` stack to run a set of ISP controls and collect metrics on a [Raspberry Pi](https://www.raspberrypi.org/).

[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/fmdlc) [![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/fmdlc)

[Fibertel](http://www.fibertel.com/), the most popular Argentinian Internet provider always has connectivity issues. It inspired me to use a Raspberry Pi and build some type of monitoring to aggregate metrics. I have been using [Grafana](http://grafana.com) at work for several years, so why not use the same logic?.

`ISP-Checker` implements a set of [Telegraf](https://github.com/influxdata/telegraf) checks that sends metrics to [InfluxDB](https://www.influxdata.com/) (a OpenSource, time series based database) and runs several kind of metrics collectors to get average/aggregation/integral of values at first glance and focusing on  service quality.

`ISP-Checker` tries to test things like _ICMP packet loss_, the average time for _DNS queries resolution_, _HTTP Response times_, _ICMP latencies_, _ICMP Standard Deviation_, _Upload/Download speed_ (by using [Speedtest-cli](https://github.com/sivel/speedtest-cli)) and a Graphical _MTR/Traceroute_ version.

It's easily extensible and it was built on top of [Docker](http://docker.com) to make it portable and easy to run everywhere, importing automatically all components needed to perform checks.

Feel free to reach me out for any feedback or ideas! :-)

## Table of contents

1. [ Platforms ](#Platforms)
2. [ Download ](#Grafana)
3. [ Configuration ](#Configuration)
5. [ Installation ](#Installation)
6. [ Login ](#Login)
7. [ Removing ](#Removing)
8. [ Concepts ](#Cooncepts)
12. [ ToDo ](#ToDo)
13. [ Contributing ](#Contributing)
14. [ License ](#License)

<center>
<img src="./img/demo.gif" />
</center>

#### Platforms
The following platforms are supported:
* `linux/amd64`.
* `linux/arm/v7`,
* `linux/arm64`.

#### Download
You can easily import this dashboard into your current Grafana installation getting it from the Official's [Grafana repository](https://grafana.com/grafana/dashboards/13140).

### Configuration

Make sure you have the [Docker-CE](https://phoenixnap.com/kb/docker-on-raspberry-pi) and [cURL](https://curl.haxx.se/) installed on your *Raspberry Pi*. If you don't, install it using your prefer method.
```bash
$ curl -fsSL https://get.docker.com -o get-docker.sh | bash -
```
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

---
## Concepts

### Bandwith
Bandwidth is the maximum rate of data transfer across a given path. Bandwidth may be characterized as network bandwidth or data bandwidth.
The difference between internet speed and bandwidth can be summed in one line. Internet bandwidth is about how much data can be download or uploaded from your computer, while internet speed is how fast can the data be uploaded or downloaded on your computer.

### Packet loss
Packet loss can be caused by a number of issues, but the most common are:

* Network congestion, as its name suggests, occurs when a network becomes congested with traffic and hits maximum capacity. Packets must wait their turn to be delivered, but if the connection falls so far behind that it cannot store any more packets, they will simply be discarded or ignored so that the network can catch up. The good news is that today's applications are able to gracefully handle discarded packets by resending data automatically or slowing down transfer speeds.

* Software bugs are another common cause of packet loss. If rigorous testing has not been carried out or bugs have been introduced following software updates, this could result in unintended or unexpected network behavior. Sometimes rebooting can resolve this issues, but more often than not the software will need to be updated or patched.

* Faulty or outdated network hardware such as firewalls, network switches and routers can slow down network traffic considerably. As a company grows and starts to experience lag, packet loss and total connectivity drops, this hardware needs to be revised and updated so that it can manage the growing throughput.

### Difference between latency and jitter
Download and upload are important metrics but don't paint the entire picture of the quality of your Internet connection. Many of us find ourselves interacting with work and friends over videoconferencing software more than ever. Although speeds matter, video is also very sensitive to the latency of your Internet connection. Latency represents the time an IP packet needs to travel from your device to the service you're using on the Internet and back. High latency means that when you're talking on a video conference, it will take longer for the other party to hear your voice.

But, latency only paints half the picture. Imagine yourself in a conversation where you have some delay before you hear what the other person says. That may be annoying but after a while you get used to it. What would be even worse is if the delay differed constantly: sometimes the audio is almost in sync and sometimes it has a delay of a few seconds. You can imagine how often this would result into two people starting to talk at the same time. This is directly related to how stable your latency is and is represented by the jitter metric. Jitter is the average variation found in consecutive latency measurements. A lower number means that the latencies measured are more consistent, meaning your media streams will have the same delay throughout the session.

---

![https://github.com/fmdlc/ISP-Checker/blob/master/img/img_4.png?raw=true](https://github.com/fmdlc/ISP-Checker/blob/master/img/img_4.png?raw=true)
![https://github.com/fmdlc/ISP-Checker/blob/master/img/img_1.png?raw=true](https://github.com/fmdlc/ISP-Checker/blob/master/img/img_1.png?raw=true)

## ToDo
- [X] Enable Network-dashboard as default dashboard.
- [ ] Allows users to select their metrics endpoint.
- [ ] Allow users to select their Grafana Org.
- [ ] Helm Chart to run in Kubernetes.
- [ ] Enable HTTPS support.
- [X] Enable Interfaces configuration.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
ISP-Checker is licensed under [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license.
