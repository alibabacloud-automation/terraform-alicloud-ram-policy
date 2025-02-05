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
  source = "../../modules/AhasApplicaitonFullAccess"
  ahas_namespace = "ns1"
  ahas_applications = ["app1", "app2"]
}
