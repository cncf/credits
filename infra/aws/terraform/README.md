# CNCF Credits AWS infra

## Initialization

Prepare a bucket for tfstate

```bash
aws s3 mb s3://cncf-credits-tfstate
```

Initialize terraform

```bash
terraform init
```
