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
