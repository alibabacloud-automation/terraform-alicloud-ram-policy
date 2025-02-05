terraform {
  required_version = ">= 1.0"

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = ">= 1.220.0"
    }
  }
}

module "example" {
  source = "../../modules/CrRepositoryFullAccess"
  cr_namespace = "ns1"
  cr_repositories = ["repo1", "repo2"]
}
