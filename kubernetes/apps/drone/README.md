# drone

## Example

`.drone.yml`:

```yaml
---
kind: pipeline
type: kubernetes
name: hello-world

trigger:
  event:
    - push

steps:
  - name: say-hello
    image: busybox
    commands:
      - echo hello-world
```
