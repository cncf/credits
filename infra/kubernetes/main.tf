terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_organizations_organization" "Root" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_organizations_organizational_unit" "kubernetes-2022-q1" {
  name      = "kubernetes-2022-q1"
  parent_id = aws_organizations_organization.Root.id
}

resource "aws_organizations_account" "kubernetes" {
  name                       = "k8s-infra-aws-root-account"
  email                      = "k8s-infra-aws-root-account@kubernetes.io"
  iam_user_access_to_billing = "ALLOW"
  parent_id                  = aws_organizations_organizational_unit.kubernetes-2022-q1.id
}

output "kubernetes" {
  value = aws_organizations_account.kubernetes
}

resource "aws_organizations_account" "sig-release-leads" {
  name                       = "sig-release-leads"
  email                      = "sig-release-leads@kubernetes.io"
  iam_user_access_to_billing = "ALLOW"
  parent_id                  = aws_organizations_organizational_unit.kubernetes-2022-q1.id
}

output "sig-release-leads" {
  value = aws_organizations_account.sig-release-leads
}
