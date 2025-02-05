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
  source = "../../modules/OssBucketFullAccessDenyDelete"
  oss_bucket_name = "bkt1"
  oss_object_names = ["dir/file1", "dir/file2"]
}
