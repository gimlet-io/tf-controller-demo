# Welcome to tf-controller-demo

## 1. Create a cluster using k3d

```
k3d cluster create tf-controller-demo
```

## 2. Install Flux

```bash
kubectl apply -f flux/flux.yaml
kubectl wait --for condition=established --timeout=60s crd/helmreleases.helm.toolkit.fluxcd.io
kubectl wait --for condition=established --timeout=60s crd/helmrepositories.source.toolkit.fluxcd.io
```

## 2. Install Terraform controller

```bash
kubectl apply -f helm-releases/tf-controller.yaml
```

Verify the startup with:

```bash
kubectl get pods -A | grep tf-controller
```

## 3. Prepare CIVO Cloud API key as a Kubernetes secret

```
kubectl create secret generic civo-credentials -n flux-system \
  --from-literal=api_key=your-api-key
```

## 3. Provision a CIVO VM instance using tf-controller

```bash
kubectl apply -f manifests/civo-instance.yaml
```

Then watch the terraform object:

```bash
kubectl get terraform -n flux-system -w
```

Also, you can check the logs of terraform apply on the tf-runner:

```bash
kubectl logs -n flux-system  -f civo-instance-tf-runner
```

## 4. Clean up the CIVO VM instance and the cluster

```bash
kubectl delete -f manifests/civo-instance.yaml
```

Then watch the changes:

```
kubectl get terraform -n flux-system -w
```

```
kubectl logs -n flux-system  -f civo-instance-tf-runner
```

Finally, delete the cluster `k3d cluster delete tf-controller-demo`
