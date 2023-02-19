# Cheat Sheet

In k9s use `s` in main page to get shell access inside the pod.

```bash
git -c http.sslVerify=false clone [URL]
```

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

```bash
kubectl get nodes --show-labels
```

```bash
kubectl describe kustomization core -n flux-system
```

```bash
flux suspend hr whoami -n networking
flux resume hr whoami -n networking
```

```bash
kubectl get csidrivers
```

```
kubectl get pv prometheus -n monitoring -o yaml > override.yaml
# adjust the yaml file
kubectl replace -f override.yaml
```

```bash
kubectl -n flux-system patch kustomization flux-system -p '{"metadata":{"finalizers":null}}'
```

rerun storage creation now:

```bash
kubectl delete job longhorn-volume-setup -n storage
flux reconcile kustomization longhorn-storage
```

```bash
# see https://kubevirt.io/user-guide/virtual_machines/virtual_machine_instances/
kubectl create -f vmi.yaml
kubectl get vmis -A
kubectl get virtualmachines -A
virtctl ssh -n kubevirt vm-cirros
kubectl delete vmis testvmi
```

```bash
kubectl get events --watch -A | grep -E "(Warning|Error)" | grep -vE "(Readiness|MountVolume)"
```

```bash
kubectl get pods -A --show-labels
```

```bash
kubectl drain $NODE_NAME --ignore-daemonsets=true --delete-emptydir-data=true --disable-eviction=true --grace-period=60 --pod-selector=app.kubernetes.io/instance!=longhorn,app.kubernetes.io/instance!=kyverno --timeout=300s
# after reboot
kubectl uncordon $NODE_NAME
```
