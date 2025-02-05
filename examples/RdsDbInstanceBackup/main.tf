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
  source = "../../modules/RdsDbInstanceBackup"
  rds_dbinstances = ["db-abcdefghijk01", "db-abcdefghijk02"]
}
