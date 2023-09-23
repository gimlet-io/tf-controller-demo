# A workflow

```bash
kubectl create secret generic civo-database-credentials -n flux-system \
  --from-literal=host=server-ip \
  --from-literal=admin_username=root \
  --from-literal="admin_password=xxx"
```

```bash
gimlet manifest template -f .gimlet/myapp-staging.yaml
```

```bash
kubectl get terraform -n flux-system -w
```

```bash
kubectl logs -n flux-system -f my-app-db-tf-runner
```
