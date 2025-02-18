module "example" {
  source = "../../modules/OssBucketFullAccessDenyDelete"
  oss_bucket_name = "bkt1"
  oss_object_names = ["dir/file1", "dir/file2"]
}