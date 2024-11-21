# kubestarter
Easy to use restarter of K8s statefulsets that can be used isntead of watchdog for memory leack

To deploy:

Build a docker image:
```
docker build src -f src/Dockerfile -t yourname/kubestarter
```

Push image to registry

Update `kubestarter.yaml` with your namespaces, sts and schedule

Apply:
```
kubectl apply -f kubestarter.yaml
```
Be aware that it's untested product
