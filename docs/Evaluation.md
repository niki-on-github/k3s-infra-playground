ArgoCD vs Flux v2

- ArgoCD does not inbuilt secrets management.
  - Solution 1: We need an custom ArgoCD docker image with kustomize and sops included. This require a CI to auto build the image on ArgoCD updates.
  - Solution 2: Patch repo-server-deployment to use some separate init container that serves sops.
- ArgoCD has no Variable Substitution
- Argo does not support Dependency Ordering [#7437](https://github.com/argoproj/argo-cd/issues/7437)
  - Solution 1: Use Syncwaves and Synchooks to order how Argo CD applies individual manifests within an Argo CD Application. The order is specified by annotating the object (argocd.argoproj.io/sync-wave annotation) with the desired order to apply the manifest. Sync-wave is a integer number (negative numbers are allowed) indicating the order. Manifest files containing lower numbers of synch-waves are applied first.
- Inline configuration in the HelmRelease resource not possible
  - Solution: use `values` file or parameter `name` + `value`.
