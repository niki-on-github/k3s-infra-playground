# K3S Homelab

Playground for my upcoming kubernetes homelab managed with Flux and Renovate.

## Clone

On the new system the self signed certificate of my git server is not in trusted store so we need the following command to clone the repository with https:

```
git -c http.sslVerify=false clone [URL]
```

## Deploy Cluster

For the deployment we use the [go-task](https://github.com/go-task/task) tool:

```bash
go-task cluster:install
```
