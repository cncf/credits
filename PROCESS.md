# Process

## Preface

This document is set out to describe the processes and guidelines for cloud based resource management related to CNCF credits and the CNCF credits program.

A great deal is not automated or not yet possible to automate.

repos:

- [cncf/credits](https://github.com/cncf/credits) :: submissions, tickets and Terraform
- [cncf-infra/aws-infra](https://github.com/cncf-infra/aws-infra) :: Terraform for AWS

## Management

### Account creation

New accounts are to be created in a structured form under org units for organization.

```
CNCF root account (org)
├── [PROJECT] (org unit)
│   ├── [PROJECT] (account)
│   │   ├── [user email address] (iam user)
│   │   ├── ...
...
```

#### Inside a project

Some initial resources and configuration must be set up upon new account creation, these include

- initial IAM user(s)
- audit trail policy
