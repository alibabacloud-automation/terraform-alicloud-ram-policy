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
  source = "../../modules/PostLogToSlsProject"
  sls_project = "prj1"
  sls_logstores = ["logstore1", "logstore2"]
}
