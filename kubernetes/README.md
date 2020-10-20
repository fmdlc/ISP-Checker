## Kubernetes
The following configuration files are used to deploy this stack in Kubernetes.
You need to update them before running in your cluster.

> ***NOTE***: The Kubernetes deployment is in *BETA* version. Don't worry if you see something wrong here.

## Installing, the quick way:

1) Apply the `ISP-Checker-deploy.yaml`
```bash
$: kubectl apply -f ISP-Checker-deploy.yaml
```

### Configuration

1) Edit `secrets.yaml` in order to initialize your InfluxDB database.
2) Edit `configmap.yaml` to configure Telegraf.
3) Apply the other `YAML` files.
4) Expose your deployment or create a LoadBalancer/IngressRule to access Grafana.

### Accesing
#### LoadBalancer
If you want to use a `LoadBalancer` to access Grafana, run:
```bash
$: kubectl expose deployments/grafana --type=LoadBalancer --name=grafana-svc
```
#### port-foward
If you can't use a LoadBalancer, you can use a `ClusterIP` service and forward to your local port.

```
$: kubectl expose deployments/grafana --type=ClusterIP --name=grafana-svc
```

And finally use your IngressController to access the service or a `port-forward`:

```
$: kubectl port-forward svc/grafana-svc 3000:3000 -n monitoring
```
