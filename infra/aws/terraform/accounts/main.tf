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

variable "alert-emails" {
  type    = list(string)
  default = ["projects@cncf.io", "jeefy@cncf.io"]
}

module "cncf-credits-terraform-test" {
  source = "./cncf-credits-terraform-test"

  providers = {
    aws = aws.account-187848499701-role-OrganizationAccountAccessRole
  }

  global-alert-emails = var.alert-emails
}

module "cncf-linkerd" {
  source = "./linkerd"

  providers = {
    aws = aws.account-594604573825-role-OrganizationAccountAccessRole
  }

  global-alert-emails = var.alert-emails
}

module "cncf-spire" {
  source = "./spire"

  providers = {
    aws = aws.account-496856297140-role-OrganizationAccountAccessRole
  }

  global-alert-emails = var.alert-emails
}
