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
  source = "../../modules/OtsInstanceGetRow"
  ots_instance = "inst1"
  ots_tables = ["tbl1", "tbl2"]
}
