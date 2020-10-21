# CHANGELOG

## Octobre 21 2020 - v1.4 (Beta)
* Improved Kubernetes documentation.
* Improved main documentation.
* Updated Grafana deployment to use a `PersistentVolume`.
* Updated Dashboard to reflect real ISP latencies.
* Created initial Kubernetes YAML files.
* Updated documentation.

## October 16 2020 - v1.3
* API configuration is now executed using `cURL` [Docker image](https://hub.docker.com/r/curlimages/curl).
* `README.md` updated (Solving [https://github.com/fmdlc/ISP-Checker/issues/14](https://github.com/fmdlc/ISP-Checker/issues/14)).

## October 12 2020 - v1.2
* Enabling CI build a multi-architecture Docker image (Extending support to `linux/amd64`, `linux/arm/v7`, `linux/arm64`)
* Fixing Docker images version on Docker Compose.
* Improving Dashboard look and feel.
* Updated `mtr` exeuction period for a best performance.
* Updated `speedtest-cli` execution period to reduce bandwith usage.
* Updated `README.md`

## October 10 2020 - v1.1

* Updated Speedtest checks to run once per hour (before was every 5 minutes).
* Removed Telegraf' Speedtest `--no-pre-allocate` version.
* Improved MTR metrics.
* Created Jitter monitoring panel.
* Created availability row and panels.
* Created Ping per destination panel.
* Included variables to define panel data.
* Updated Speedtest checks to run once peer hour (before was every 5 minutes).
* Removed Telegraf' Speedtest `--no-pre-allocate` version.
* Created Jitter monitoring panel.
* Created availability row and panels.
* Created Ping per destination panel.
* Included variables to define panels data.
* Addeed netstat stadistics.
* Updated documentation.
* Included system metrics dashboard.
* Created CHANGELOG.md
