# Welcome to tf-controller-demo

## Fork this repository

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

## 3. Install Terraform controller

```bash
kubectl apply -f helm-releases/tf-controller.yaml
```

Verify the startup with:

```bash
kubectl get pods -A | grep tf-controller
```

## 4. Prepare CIVO Cloud API key as a Kubernetes secret

```
kubectl create secret generic civo-credentials -n flux-system \
  --from-literal=api_key=your-api-key
```

```
sh create-secret.sh
```

## Point manifests to your fork

Update `manifests/civo-instance.yaml` to point to your fork instead of `https://github.com/gimlet-io/tf-controller-demo`

## 5. Provision a CIVO VM instance using tf-controller

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

## 6. Make changes to the VM instance

- Add a new tag in `terraform/civo-instance-demo-resources/main.tf`
- Push changes to git.

Then watch the terraform object:

```bash
kubectl get terraform -n flux-system -w
```

Also, you can check the logs of terraform apply on the tf-runner:

```bash
kubectl logs -n flux-system -f civo-instance-tf-runner
```

## 7. Clean up the CIVO VM instance and the cluster

Finally, delete the cluster `k3d cluster delete tf-controller-demo`
