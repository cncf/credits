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

terraform {
  backend "s3" {
    bucket = "cncf-credits-tfstate"
    key    = "terraform.tfstate"
    region = "ap-southeast-2"
  }

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 3.0"
      configuration_aliases = [aws.us-east-2]
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  region = "us-west-1"
  alias  = "account-187848499701-role-OrganizationAccountAccessRole"

  # email: caleb+cncf-credits-terraform-test@ii.coop
  assume_role {
    role_arn = "arn:aws:iam::187848499701:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  region = "us-west-1"
  alias  = "account-594604573825-role-OrganizationAccountAccessRole"

  # email: cncf-linkerd-aws-account@cncf.io
  assume_role {
    role_arn = "arn:aws:iam::594604573825:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  region = "us-west-1"
  alias  = "account-496856297140-role-OrganizationAccountAccessRole"

  # email: cncf-spire-account-admin@cncf.io
  assume_role {
    role_arn = "arn:aws:iam::496856297140:role/OrganizationAccountAccessRole"
  }
}
