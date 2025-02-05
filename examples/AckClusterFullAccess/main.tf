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
  source = "../../modules/AckClusterFullAccess"
  ack_clusters = ["cls1", "cls2"]
}
