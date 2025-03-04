resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/OssBucketFullAccessDenyDelete"
  oss_bucket_name    = "bkt1"
  oss_object_names   = ["dir/file1", "dir/file2"]
  policy_name_suffix = random_integer.suffix.result
}