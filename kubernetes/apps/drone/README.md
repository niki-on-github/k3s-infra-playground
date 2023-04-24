# [Drone](https://www.drone.io/)

Drone is an open source Continuous Integration and Delivery platform built completely on docker.

## Usage

### Example

In your git repository create a `.drone.yml` with following example config:

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
