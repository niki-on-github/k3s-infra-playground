# Tool Evaluation

## ArgoCD vs Flux v2

### Limitation of ArgoCD

Below are the identified limitations of ArgoCD and possible solutions and workarounds for the insufficient functionality.

#### ArgoCD does not includes secrets management

- We could use a custom ArgoCD docker image with kustomize and sops included. This require a CI to auto build the image on ArgoCD updates.
- Patch repo-server-deployment to use some separate init container that serves sops provider.

#### ArgoCD has no Variable Substitution

- Omission of a central configuration file. This will make the administration more complex.

#### ArgoCD does not support Dependency Ordering [#7437](https://github.com/argoproj/argo-cd/issues/7437)

- Use Syncwaves and Synchooks to order how Argo CD applies individual manifests within an Argo CD Application. The order is specified by annotating the object (argocd.argoproj.io/sync-wave annotation) with the desired order to apply the manifest. Sync-wave is a integer number (negative numbers are allowed) indicating the order. Manifest files containing lower numbers of synch-waves are applied first.

#### Inline configuration in the HelmRelease resource not possible

- Use `values` file or parameter `name` + `value`.
