# K3S Homelab

Playground for my upcoming kubernetes homelab.

## Deploy Cluster

```bash
go-task cluster:install
```

## Cheat Sheet

```bash
flux delete kustomization apps
flux reconcile kustomization apps
```

```bash
kubectl get pods -A
kubectl delete pod authentik-server-5d6777b4f7-hw64w -n ingress
```

```bash
kubectl get svc -n ingress
kubectl get svc authentik -n ingress -o yaml
```

```bash
kubectl describe helmreleases thanos -n monitoring
```

```bash
kubectl get tenant -n  monitoring
```

```bash
kubectl get clusterissuers ca-issuer
```

```bash
kubectl api-resources -o wide
```

1
