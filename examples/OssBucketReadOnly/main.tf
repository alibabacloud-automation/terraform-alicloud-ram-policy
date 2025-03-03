resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/OssBucketReadOnly"
  oss_bucket_name    = "bkt1"
  oss_object_names   = ["file1", "file2"]
  policy_name_suffix = random_integer.suffix.result
}