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

variable "amount" {
  type = string
}

variable "project" {
  type = string
}

variable "alert-emails" {
  type = list(string)
}

variable "threshold" {
  type    = number
  default = 75
}

resource "aws_budgets_budget" "project-budget" {
  name         = "budget-${var.project}-monthly"
  budget_type  = "COST"
  limit_amount = var.amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.alert-emails
  }
}

resource "aws_budgets_budget" "project-budget-ceiling" {
  name         = "budget-${var.project}-monthly-ceiling"
  budget_type  = "COST"
  limit_amount = 100
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.alert-emails
  }
}
