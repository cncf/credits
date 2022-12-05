/*
Copyright 2022 The CNCF Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

variable "user-email-addresses" {
  type = list(string)
  default = [
    "azdagron@gmail.com",
    "ryan.turner253@icloud.com",
    "amartinezfayo@gmail.com",
    "evan2645@gmail.com",
    "marcosyacob@gmail.com"
  ]
}
variable "project-alert-emails" {
  type = list(string)
  default = [
    "cncf-spire-account-admin@cncf.io",
  ]
}
variable "global-alert-emails" {
  type = list(string)
}
variable "project" {
  type    = string
  default = "cncf-spire"
}
variable "budget-usd" {
  type    = string
  default = "500"
}

module "cloudtrail" {
  source = "../../reusables/cloudtrail"

  providers = {
    aws = aws
  }

  project = var.project
}

module "budget" {
  source = "../../reusables/budget"

  providers = {
    aws = aws
  }

  project      = var.project
  amount       = var.budget-usd
  alert-emails = concat(var.global-alert-emails, var.project-alert-emails, var.user-email-addresses)
}

// permissions
resource "aws_iam_group" "group" {
  name = var.project
}
// TODO figure out permissions
resource "aws_iam_policy" "policy" {
  name        = "${var.project}-policy"
  description = "A policy for group members in the project ${var.project}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "kms:*",
          "secretsmanager:*",
          "acm-pca:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "iam:AddRoleToInstanceProfile",
          "iam:AddUserToGroup",
          "iam:ChangePassword",
          "iam:CreateAccessKey",
          "iam:CreateGroup",
          "iam:CreateInstanceProfile",
          "iam:CreateRole",
          "iam:CreateUser",
          "iam:DeleteAccessKey",
          "iam:DeleteGroup",
          "iam:DeleteInstanceProfile",
          "iam:DeleteRole",
          "iam:DeleteUser",
          "iam:GetAccessKeyLastUsed",
          "iam:GetAccountSummary",
          "iam:GetInstanceProfile",
          "iam:GetLoginProfile",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:GetSSHPublicKey",
          "iam:GetServiceLastAccessedDetails",
          "iam:GetServiceLastAccessedDetailsWithEntities",
          "iam:GetUser",
          "iam:GetUserPolicy",
          "iam:ListAccountAliases",
          "iam:ListAttachedGroupPolicies",
          "iam:ListAttachedRolePolicies",
          "iam:ListAttachedUserPolicies",
          "iam:ListGroupPolicies",
          "iam:ListGroups",
          "iam:ListInstanceProfileTags",
          "iam:ListInstanceProfiles",
          "iam:ListInstanceProfilesForRole",
          "iam:ListPolicies",
          "iam:ListPoliciesGrantingServiceAccess",
          "iam:ListPolicyTags",
          "iam:ListPolicyVersions",
          "iam:ListRolePolicies",
          "iam:ListRoleTags",
          "iam:ListRoles",
          "iam:ListUserTags",
          "iam:ListUsers",
          "iam:PassRole",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:RemoveUserFromGroup",
          "iam:TagInstanceProfile",
          "iam:TagPolicy",
          "iam:TagRole",
          "iam:TagUser",
          "iam:UntagInstanceProfile",
          "iam:UntagPolicy",
          "iam:UntagRole",
          "iam:UntagUser",
          "iam:UpdateGroup",
          "iam:UpdateRole",
          "iam:UpdateUser",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_group_policy_attachment" "policy-to-group" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_user" "users" {
  for_each = toset(var.user-email-addresses)
  name     = each.value
}
resource "aws_iam_group_membership" "users-to-group" {
  name = "users-to-group"

  users = toset(var.user-email-addresses)

  group = aws_iam_group.group.name
}
