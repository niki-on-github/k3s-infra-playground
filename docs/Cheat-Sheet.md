# Cheat Sheet

Unordered useful commands for Kubernetes debugging.

```bash
flux delete kustomization apps
flux reconcile kustomization apps
```

```bash
kubectl api-resources -o wide
```

```bash
kubectl get nodes --show-labels
```

```bash
kubectl get csidrivers
```

```bash
kubectl get pv prometheus -n monitoring -o yaml > override.yaml
# adjust the yaml file
kubectl replace -f override.yaml
```

```bash
kubectl -n flux-system patch kustomization flux-system -p '{"metadata":{"finalizers":null}}'
```

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
kubectl get CustomResourceDefinition -A | grep $NAME | cut -d ' ' -f1 | xargs -I {} kubectl delete CustomResourceDefinition {} -n apps
```

## K9s

- Use `s` in main pod listing to get shell access inside the pod.
